-- ============================================================
-- IBEQA SYSTEM - DATABASE SCHEMA
-- ============================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- ENUMS
-- ============================================================

CREATE TYPE user_role AS ENUM ('ibeqa_admin', 'ibeqa_evaluator', 'institution_admin', 'institution_user');
CREATE TYPE institution_size AS ENUM ('small', 'medium', 'large');
CREATE TYPE application_type AS ENUM ('institutional', 'program');
CREATE TYPE application_status AS ENUM ('draft', 'submitted', 'under_review', 'in_evaluation', 'completed', 'withdrawn');
CREATE TYPE accreditation_result AS ENUM ('excellence', 'full', 'conditional', 'not_accredited');
CREATE TYPE accreditation_status AS ENUM ('active', 'expired', 'suspended', 'revoked');
CREATE TYPE payment_type AS ENUM ('application_fee', 'annual_fee', 'membership_fee');
CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'failed', 'refunded');
CREATE TYPE evaluator_type AS ENUM ('academic', 'quality_expert', 'research_expert', 'industry_expert');
CREATE TYPE evaluator_status AS ENUM ('active', 'inactive', 'certified', 'suspended');
CREATE TYPE maturity_level AS ENUM ('1', '2', '3', '4', '5');

-- ============================================================
-- PROFILES (extends Supabase auth.users)
-- ============================================================

CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  full_name TEXT,
  role user_role NOT NULL DEFAULT 'institution_user',
  institution_id UUID,
  avatar_url TEXT,
  phone TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- INSTITUTIONS
-- ============================================================

CREATE TABLE institutions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  legal_name TEXT,
  country TEXT NOT NULL,
  city TEXT,
  address TEXT,
  website TEXT,
  size institution_size NOT NULL DEFAULT 'medium',
  founded_year INTEGER,
  student_count INTEGER,
  logo_url TEXT,
  contact_email TEXT,
  contact_phone TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add FK from profiles to institutions
ALTER TABLE profiles ADD CONSTRAINT profiles_institution_id_fkey
  FOREIGN KEY (institution_id) REFERENCES institutions(id) ON DELETE SET NULL;

-- ============================================================
-- PROGRAMS (educational programs per institution)
-- ============================================================

CREATE TABLE programs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  institution_id UUID NOT NULL REFERENCES institutions(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  degree_level TEXT, -- bachelor, master, phd, etc.
  field TEXT,
  duration_years NUMERIC(3,1),
  modality TEXT, -- on-campus, online, hybrid
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- RUBRICS (MIAC-U model structure)
-- ============================================================

CREATE TABLE components (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  code TEXT NOT NULL UNIQUE, -- C1, C2, etc.
  name TEXT NOT NULL,
  description TEXT,
  weight NUMERIC(5,2) NOT NULL DEFAULT 12.5, -- % weight in total score
  application_type application_type NOT NULL DEFAULT 'institutional',
  sort_order INTEGER NOT NULL DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE factors (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  component_id UUID NOT NULL REFERENCES components(id) ON DELETE CASCADE,
  code TEXT NOT NULL UNIQUE, -- F1.1, F1.2, etc.
  name TEXT NOT NULL,
  description TEXT,
  weight NUMERIC(5,2) NOT NULL DEFAULT 33.33,
  sort_order INTEGER NOT NULL DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE criteria (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  factor_id UUID NOT NULL REFERENCES factors(id) ON DELETE CASCADE,
  code TEXT NOT NULL UNIQUE, -- CR1.1.1, etc.
  name TEXT NOT NULL,
  description TEXT,
  evidence_guide TEXT, -- what evidence to upload
  weight NUMERIC(5,2) NOT NULL DEFAULT 33.33,
  sort_order INTEGER NOT NULL DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE
);

-- ============================================================
-- APPLICATIONS (postulaciones)
-- ============================================================

CREATE TABLE applications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  institution_id UUID NOT NULL REFERENCES institutions(id) ON DELETE CASCADE,
  program_id UUID REFERENCES programs(id) ON DELETE SET NULL,
  type application_type NOT NULL DEFAULT 'institutional',
  status application_status NOT NULL DEFAULT 'draft',
  submitted_at TIMESTAMPTZ,
  reference_number TEXT UNIQUE, -- IBEQA-2025-0001
  notes TEXT,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Sections: one per component, stores institution responses
CREATE TABLE application_sections (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  application_id UUID NOT NULL REFERENCES applications(id) ON DELETE CASCADE,
  component_id UUID NOT NULL REFERENCES components(id),
  is_complete BOOLEAN DEFAULT FALSE,
  last_saved_at TIMESTAMPTZ,
  UNIQUE(application_id, component_id)
);

-- Criterion responses: institution fills one per criterion
CREATE TABLE criterion_responses (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  application_section_id UUID NOT NULL REFERENCES application_sections(id) ON DELETE CASCADE,
  criteria_id UUID NOT NULL REFERENCES criteria(id),
  narrative TEXT, -- institution's written response
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(application_section_id, criteria_id)
);

-- File evidence attached to criterion responses
CREATE TABLE evidence_files (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  criterion_response_id UUID NOT NULL REFERENCES criterion_responses(id) ON DELETE CASCADE,
  file_name TEXT NOT NULL,
  file_url TEXT NOT NULL,
  file_size INTEGER,
  mime_type TEXT,
  uploaded_by UUID REFERENCES profiles(id),
  uploaded_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- EVALUATORS (peer reviewers)
-- ============================================================

CREATE TABLE evaluators (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  full_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  type evaluator_type NOT NULL,
  status evaluator_status NOT NULL DEFAULT 'active',
  country TEXT,
  institution_affiliation TEXT,
  academic_degree TEXT,
  years_experience INTEGER,
  specializations TEXT[],
  bio TEXT,
  certified_at TIMESTAMPTZ,
  certification_expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- EVALUATIONS
-- ============================================================

CREATE TABLE evaluation_committees (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  application_id UUID NOT NULL REFERENCES applications(id) ON DELETE CASCADE,
  lead_evaluator_id UUID REFERENCES evaluators(id),
  scheduled_visit_date DATE,
  visit_completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE committee_members (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  committee_id UUID NOT NULL REFERENCES evaluation_committees(id) ON DELETE CASCADE,
  evaluator_id UUID NOT NULL REFERENCES evaluators(id),
  has_conflict_of_interest BOOLEAN DEFAULT FALSE,
  conflict_declared_at TIMESTAMPTZ,
  UNIQUE(committee_id, evaluator_id)
);

-- Scores per criterion per evaluator
CREATE TABLE criterion_scores (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  criterion_response_id UUID NOT NULL REFERENCES criterion_responses(id) ON DELETE CASCADE,
  evaluator_id UUID NOT NULL REFERENCES evaluators(id),
  score maturity_level NOT NULL,
  justification TEXT,
  ai_suggested_score maturity_level, -- from AI agent
  ai_justification TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(criterion_response_id, evaluator_id)
);

-- Final scores aggregated per component
CREATE TABLE component_scores (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  application_id UUID NOT NULL REFERENCES applications(id) ON DELETE CASCADE,
  component_id UUID NOT NULL REFERENCES components(id),
  score NUMERIC(5,2), -- weighted average 1-5
  percentage NUMERIC(5,2), -- converted to 0-100
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(application_id, component_id)
);

-- ============================================================
-- ACCREDITATIONS
-- ============================================================

CREATE TABLE accreditations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  application_id UUID NOT NULL REFERENCES applications(id),
  institution_id UUID NOT NULL REFERENCES institutions(id),
  program_id UUID REFERENCES programs(id),
  type application_type NOT NULL,
  result accreditation_result NOT NULL,
  status accreditation_status NOT NULL DEFAULT 'active',
  total_score NUMERIC(5,2) NOT NULL, -- 0-100
  granted_at DATE NOT NULL,
  expires_at DATE NOT NULL,
  certificate_url TEXT,
  decision_notes TEXT,
  decided_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- PAYMENTS
-- ============================================================

CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  institution_id UUID NOT NULL REFERENCES institutions(id),
  application_id UUID REFERENCES applications(id),
  accreditation_id UUID REFERENCES accreditations(id),
  type payment_type NOT NULL,
  status payment_status NOT NULL DEFAULT 'pending',
  amount NUMERIC(10,2) NOT NULL,
  currency TEXT NOT NULL DEFAULT 'USD',
  stripe_payment_intent_id TEXT,
  stripe_invoice_id TEXT,
  paid_at TIMESTAMPTZ,
  due_date DATE,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- SEED: MIAC-U COMPONENTS (8 components)
-- ============================================================

INSERT INTO components (code, name, weight, sort_order) VALUES
('C1', 'Governance & Strategic Direction', 12.5, 1),
('C2', 'Curriculum Design & Relevance', 12.5, 2),
('C3', 'Quality of Teaching Process', 12.5, 3),
('C4', 'Student Development', 12.5, 4),
('C5', 'Research & Innovation', 12.5, 5),
('C6', 'Engagement with the Environment', 12.5, 6),
('C7', 'Graduate Outcomes & Impact', 12.5, 7),
('C8', 'Quality Assurance System', 12.5, 8);

-- Factors for C1
INSERT INTO factors (component_id, code, name, weight, sort_order) VALUES
((SELECT id FROM components WHERE code='C1'), 'F1.1', 'Impact-Oriented Mission', 33.33, 1),
((SELECT id FROM components WHERE code='C1'), 'F1.2', 'Strategic Planning', 33.33, 2),
((SELECT id FROM components WHERE code='C1'), 'F1.3', 'Academic Governance', 33.33, 3);

-- Factors for C2
INSERT INTO factors (component_id, code, name, weight, sort_order) VALUES
((SELECT id FROM components WHERE code='C2'), 'F2.1', 'Program Relevance', 33.33, 1),
((SELECT id FROM components WHERE code='C2'), 'F2.2', 'Competency-Based Design', 33.33, 2),
((SELECT id FROM components WHERE code='C2'), 'F2.3', 'Curriculum Update', 33.33, 3);

-- Factors for C3
INSERT INTO factors (component_id, code, name, weight, sort_order) VALUES
((SELECT id FROM components WHERE code='C3'), 'F3.1', 'Learning Methodologies', 33.33, 1),
((SELECT id FROM components WHERE code='C3'), 'F3.2', 'Learning Assessment', 33.33, 2),
((SELECT id FROM components WHERE code='C3'), 'F3.3', 'Educational Technology', 33.33, 3);

-- Factors for C4
INSERT INTO factors (component_id, code, name, weight, sort_order) VALUES
((SELECT id FROM components WHERE code='C4'), 'F4.1', 'Academic Support', 33.33, 1),
((SELECT id FROM components WHERE code='C4'), 'F4.2', 'Transversal Skills Development', 33.33, 2),
((SELECT id FROM components WHERE code='C4'), 'F4.3', 'Practical Experience', 33.33, 3);

-- Factors for C5
INSERT INTO factors (component_id, code, name, weight, sort_order) VALUES
((SELECT id FROM components WHERE code='C5'), 'F5.1', 'Scientific Production', 33.33, 1),
((SELECT id FROM components WHERE code='C5'), 'F5.2', 'Innovation & Transfer', 33.33, 2),
((SELECT id FROM components WHERE code='C5'), 'F5.3', 'Applied Research', 33.33, 3);

-- Factors for C6
INSERT INTO factors (component_id, code, name, weight, sort_order) VALUES
((SELECT id FROM components WHERE code='C6'), 'F6.1', 'Employer Relations', 33.33, 1),
((SELECT id FROM components WHERE code='C6'), 'F6.2', 'Continuing Education', 33.33, 2),
((SELECT id FROM components WHERE code='C6'), 'F6.3', 'Social Responsibility', 33.33, 3);

-- Factors for C7
INSERT INTO factors (component_id, code, name, weight, sort_order) VALUES
((SELECT id FROM components WHERE code='C7'), 'F7.1', 'Graduate Employability', 33.33, 1),
((SELECT id FROM components WHERE code='C7'), 'F7.2', 'Professional Development', 33.33, 2),
((SELECT id FROM components WHERE code='C7'), 'F7.3', 'Employer Satisfaction', 33.33, 3);

-- Factors for C8
INSERT INTO factors (component_id, code, name, weight, sort_order) VALUES
((SELECT id FROM components WHERE code='C8'), 'F8.1', 'Institutional Evaluation', 33.33, 1),
((SELECT id FROM components WHERE code='C8'), 'F8.2', 'Data-Driven Management', 33.33, 2),
((SELECT id FROM components WHERE code='C8'), 'F8.3', 'Continuous Improvement', 33.33, 3);

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE institutions ENABLE ROW LEVEL SECURITY;
ALTER TABLE programs ENABLE ROW LEVEL SECURITY;
ALTER TABLE applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE application_sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE criterion_responses ENABLE ROW LEVEL SECURITY;
ALTER TABLE evidence_files ENABLE ROW LEVEL SECURITY;
ALTER TABLE accreditations ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE evaluators ENABLE ROW LEVEL SECURITY;
ALTER TABLE criterion_scores ENABLE ROW LEVEL SECURITY;

-- Helper function: get current user role
CREATE OR REPLACE FUNCTION get_user_role()
RETURNS user_role AS $$
  SELECT role FROM profiles WHERE id = auth.uid();
$$ LANGUAGE SQL SECURITY DEFINER;

-- Helper function: get current user institution
CREATE OR REPLACE FUNCTION get_user_institution_id()
RETURNS UUID AS $$
  SELECT institution_id FROM profiles WHERE id = auth.uid();
$$ LANGUAGE SQL SECURITY DEFINER;

-- Profiles: users see their own profile; admins see all
CREATE POLICY "Users can view own profile" ON profiles FOR SELECT USING (id = auth.uid());
CREATE POLICY "IBEQA admins can view all profiles" ON profiles FOR SELECT USING (get_user_role() IN ('ibeqa_admin', 'ibeqa_evaluator'));
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (id = auth.uid());

-- Institutions: institution users see their own; IBEQA sees all
CREATE POLICY "Institution members can view own institution" ON institutions FOR SELECT
  USING (id = get_user_institution_id() OR get_user_role() IN ('ibeqa_admin', 'ibeqa_evaluator'));
CREATE POLICY "IBEQA admins can manage institutions" ON institutions FOR ALL
  USING (get_user_role() = 'ibeqa_admin');
CREATE POLICY "Institution admins can update own institution" ON institutions FOR UPDATE
  USING (id = get_user_institution_id() AND get_user_role() = 'institution_admin');

-- Applications: institutions see their own; IBEQA sees all
CREATE POLICY "Institution members can view own applications" ON applications FOR SELECT
  USING (institution_id = get_user_institution_id() OR get_user_role() IN ('ibeqa_admin', 'ibeqa_evaluator'));
CREATE POLICY "Institution members can create applications" ON applications FOR INSERT
  WITH CHECK (institution_id = get_user_institution_id());
CREATE POLICY "Institution members can update draft applications" ON applications FOR UPDATE
  USING (institution_id = get_user_institution_id() AND status = 'draft');
CREATE POLICY "IBEQA admins can update any application" ON applications FOR UPDATE
  USING (get_user_role() = 'ibeqa_admin');

-- Accreditations: public read for active; full access for IBEQA admin
CREATE POLICY "Anyone can view active accreditations" ON accreditations FOR SELECT
  USING (status = 'active' OR institution_id = get_user_institution_id() OR get_user_role() IN ('ibeqa_admin', 'ibeqa_evaluator'));
CREATE POLICY "IBEQA admins can manage accreditations" ON accreditations FOR ALL
  USING (get_user_role() = 'ibeqa_admin');

-- Payments: institutions see own; IBEQA sees all
CREATE POLICY "Institution members can view own payments" ON payments FOR SELECT
  USING (institution_id = get_user_institution_id() OR get_user_role() = 'ibeqa_admin');

-- Evaluators: IBEQA full access; evaluators see own record
CREATE POLICY "IBEQA can manage evaluators" ON evaluators FOR ALL
  USING (get_user_role() IN ('ibeqa_admin', 'ibeqa_evaluator'));

-- ============================================================
-- FUNCTION: auto-create profile on signup
-- ============================================================

CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO profiles (id, email, full_name, role)
  VALUES (
    NEW.id,
    NEW.email,
    NEW.raw_user_meta_data->>'full_name',
    COALESCE((NEW.raw_user_meta_data->>'role')::user_role, 'institution_user')
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- ============================================================
-- FUNCTION: auto-generate reference number for applications
-- ============================================================

CREATE OR REPLACE FUNCTION generate_reference_number()
RETURNS TRIGGER AS $$
BEGIN
  NEW.reference_number := 'IBEQA-' || TO_CHAR(NOW(), 'YYYY') || '-' || LPAD(nextval('application_ref_seq')::TEXT, 4, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE SEQUENCE application_ref_seq START 1;

CREATE TRIGGER set_reference_number
  BEFORE INSERT ON applications
  FOR EACH ROW EXECUTE FUNCTION generate_reference_number();
