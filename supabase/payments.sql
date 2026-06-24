-- Payments declared by institutions (bank transfer / manual verification)
CREATE TABLE IF NOT EXISTS payments (
  id                uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  institution_id    uuid NOT NULL REFERENCES institutions(id) ON DELETE CASCADE,
  fee_type          text NOT NULL, -- 'application', 'evaluation', 'site_visit', 'certificate'
  amount_declared   numeric(10,2) NOT NULL,
  currency          text NOT NULL CHECK (currency IN ('GBP', 'EUR')),
  transfer_date     date NOT NULL,
  bank_reference    text,
  payer_name        text,
  notes             text,
  evidence_url      text,           -- Supabase Storage URL of uploaded receipt
  status            text NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'verified', 'rejected')),
  verified_by       uuid REFERENCES auth.users(id),
  verified_at       timestamptz,
  rejection_reason  text,
  submitted_by      uuid REFERENCES auth.users(id),
  created_at        timestamptz DEFAULT now(),
  updated_at        timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_payments_institution ON payments(institution_id);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(status);

ALTER TABLE payments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "institution members can view their payments"
  ON payments FOR SELECT
  USING (institution_id = (auth.jwt() -> 'user_metadata' ->> 'institution_id')::uuid);

CREATE POLICY "institution members can insert their payments"
  ON payments FOR INSERT
  WITH CHECK (institution_id = (auth.jwt() -> 'user_metadata' ->> 'institution_id')::uuid);
