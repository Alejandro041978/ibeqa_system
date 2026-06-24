-- Table to store institution responses to each MIAC-U criterion
CREATE TABLE IF NOT EXISTS application_responses (
  id            uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  institution_id uuid NOT NULL REFERENCES institutions(id) ON DELETE CASCADE,
  criteria_id   uuid NOT NULL REFERENCES criteria(id) ON DELETE CASCADE,
  response_text text,
  evidence_notes text,
  updated_by    uuid REFERENCES auth.users(id),
  updated_at    timestamptz DEFAULT now(),
  created_at    timestamptz DEFAULT now(),
  UNIQUE (institution_id, criteria_id)
);

-- Index for fast lookups by institution
CREATE INDEX IF NOT EXISTS idx_app_responses_institution ON application_responses(institution_id);

-- RLS: institutions can only read/write their own responses
ALTER TABLE application_responses ENABLE ROW LEVEL SECURITY;

CREATE POLICY "institution members can read their responses"
  ON application_responses FOR SELECT
  USING (
    institution_id = (auth.jwt() -> 'user_metadata' ->> 'institution_id')::uuid
  );

CREATE POLICY "institution members can upsert their responses"
  ON application_responses FOR INSERT
  WITH CHECK (
    institution_id = (auth.jwt() -> 'user_metadata' ->> 'institution_id')::uuid
  );

CREATE POLICY "institution members can update their responses"
  ON application_responses FOR UPDATE
  USING (
    institution_id = (auth.jwt() -> 'user_metadata' ->> 'institution_id')::uuid
  );
