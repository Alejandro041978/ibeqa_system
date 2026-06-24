-- ============================================================
-- ADD response_schema TO CRITERIA (for future structured forms)
-- ============================================================

ALTER TABLE criteria ADD COLUMN IF NOT EXISTS response_schema JSONB DEFAULT NULL;
ALTER TABLE criteria ADD COLUMN IF NOT EXISTS rubric JSONB DEFAULT NULL;

-- ============================================================
-- SEED CRITERIA WITH RUBRICS (MIAC-U Model)
-- Scale: 1=Initial, 2=Developing, 3=Implemented, 4=Consolidated, 5=Excellence
-- ============================================================

-- COMPONENT 1: Governance & Strategic Direction
-- F1.1 Impact-Oriented Mission

INSERT INTO criteria (factor_id, code, name, description, evidence_guide, weight, sort_order, rubric) VALUES
((SELECT id FROM factors WHERE code='F1.1'), 'CR1.1.1',
'Mission statement with professional impact',
'The institutional mission explicitly declares the formation of professionals who generate social and economic value.',
'Upload: Mission statement document, strategic plan, board-approved documents.',
33.33, 1,
'{"1": "Mission exists but does not mention graduate impact or employability.", "2": "Mission mentions graduate formation but without specific impact indicators.", "3": "Mission explicitly states graduate employability and social value as institutional goals.", "4": "Mission is operationalized with measurable KPIs linked to graduate outcomes.", "5": "Mission drives all institutional decisions; graduate impact is measured and publicly reported annually."}'::jsonb),

((SELECT id FROM factors WHERE code='F1.1'), 'CR1.1.2',
'Graduate success indicators defined',
'The institution defines specific indicators to measure graduate professional success.',
'Upload: KPI documents, graduate tracking system, employability reports.',
33.33, 2,
'{"1": "No graduate success indicators defined.", "2": "Basic indicators exist (graduation rate) but no employability tracking.", "3": "Employability indicators defined and tracked at 6 and 12 months.", "4": "Comprehensive indicator system including salary, job relevance, employer satisfaction.", "5": "Real-time graduate tracking system with public dashboard and employer feedback loop."}'::jsonb),

((SELECT id FROM factors WHERE code='F1.1'), 'CR1.1.3',
'Strategy aligned with labor market needs',
'The institutional strategy is aligned with current and projected labor market needs.',
'Upload: Strategic plan, labor market studies, industry partnership agreements.',
33.33, 3,
'{"1": "No evidence of labor market analysis in strategic planning.", "2": "Occasional labor market reviews but not integrated into strategy.", "3": "Annual labor market analysis informs strategic priorities.", "4": "Strategy co-developed with industry partners and updated based on market signals.", "5": "Dynamic strategy with real-time labor market data integration and employer advisory board participation."}'::jsonb),

-- F1.2 Strategic Planning
((SELECT id FROM factors WHERE code='F1.2'), 'CR1.2.1',
'Institutional strategic plan exists',
'Existence of a formal, approved institutional strategic plan with clear goals and timelines.',
'Upload: Strategic plan document with approval signatures and dates.',
33.33, 1,
'{"1": "No formal strategic plan exists.", "2": "Strategic plan exists but is outdated (>3 years) or not formally approved.", "3": "Current strategic plan (≤3 years) with defined goals and responsible parties.", "4": "Strategic plan with SMART goals, budgets, and semi-annual monitoring reports.", "5": "Living strategic plan with quarterly reviews, cascaded to all units, publicly accessible."}'::jsonb),

((SELECT id FROM factors WHERE code='F1.2'), 'CR1.2.2',
'Employability goals in strategic plan',
'Strategic plan includes specific employability and graduate professional success goals.',
'Upload: Strategic plan sections with employability goals, baseline data.',
33.33, 2,
'{"1": "No employability goals in strategic plan.", "2": "General mention of graduate outcomes without specific targets.", "3": "Specific employability rate targets defined for next planning period.", "4": "Employability goals with baselines, targets, responsible units, and review schedule.", "5": "Employability as a top-3 institutional priority with dedicated resources and board oversight."}'::jsonb),

((SELECT id FROM factors WHERE code='F1.2'), 'CR1.2.3',
'Strategic plan monitoring and reporting',
'Regular monitoring of strategic plan compliance with documented evidence.',
'Upload: Monitoring reports, dashboards, board meeting minutes with progress reviews.',
33.33, 3,
'{"1": "No monitoring of strategic plan.", "2": "Annual review of strategic plan but without structured reports.", "3": "Bi-annual monitoring with written reports presented to leadership.", "4": "Quarterly monitoring with dashboards available to internal stakeholders.", "5": "Real-time monitoring dashboard; results trigger corrective actions within 30 days."}'::jsonb),

-- F1.3 Academic Governance
((SELECT id FROM factors WHERE code='F1.3'), 'CR1.3.1',
'Collegiate academic governance bodies',
'Existence and functioning of collegiate academic governance bodies with defined roles.',
'Upload: Governance statutes, meeting minutes (last 12 months), member composition.',
33.33, 1,
'{"1": "No collegiate governance bodies or they exist only formally without meetings.", "2": "Governance bodies exist and meet occasionally (less than quarterly).", "3": "Governance bodies meet regularly (quarterly+) with documented decisions.", "4": "Active governance with clear roles, quorum requirements, and decision tracking.", "5": "Governance bodies drive institutional quality agenda with external member participation."}'::jsonb),

((SELECT id FROM factors WHERE code='F1.3'), 'CR1.3.2',
'External stakeholder participation in governance',
'Industry and external stakeholders participate in academic governance bodies.',
'Upload: Advisory board composition, meeting minutes, industry partner agreements.',
33.33, 2,
'{"1": "No external stakeholder participation in governance.", "2": "Occasional consultation with external parties but no formal governance role.", "3": "External advisory committee meets at least twice a year.", "4": "Industry representatives are voting members of academic councils.", "5": "External stakeholders co-chair academic quality committees and co-design programs."}'::jsonb),

((SELECT id FROM factors WHERE code='F1.3'), 'CR1.3.3',
'Transparency in academic decisions',
'Academic decisions are documented, communicated, and accessible to the institutional community.',
'Upload: Decision logs, communication policies, intranet/portal with published decisions.',
33.33, 3,
'{"1": "Academic decisions are not documented or communicated.", "2": "Decisions documented but not systematically communicated.", "3": "Decisions published on intranet within 30 days of approval.", "4": "Real-time publication of decisions with rationale and implementation status.", "5": "Open governance model with community input mechanisms and public accountability reports."}'::jsonb),

-- COMPONENT 2: Curriculum Design & Relevance
-- F2.1 Program Relevance
((SELECT id FROM factors WHERE code='F2.1'), 'CR2.1.1',
'Labor market demand studies',
'The institution conducts labor market demand studies to validate program relevance.',
'Upload: Labor market studies (last 3 years), methodology, data sources.',
33.33, 1,
'{"1": "No labor market studies conducted.", "2": "Studies conducted but more than 3 years old or limited scope.", "3": "Labor market study conducted in last 3 years with primary data collection.", "4": "Annual labor market monitoring with employer surveys and graduate tracking.", "5": "Continuous labor market intelligence system with real-time industry data and employer panels."}'::jsonb),

((SELECT id FROM factors WHERE code='F2.1'), 'CR2.1.2',
'International benchmark of curriculum',
'Programs are benchmarked against leading international programs in the same field.',
'Upload: Benchmark reports, comparison matrices, international accreditation references.',
33.33, 2,
'{"1": "No international benchmarking conducted.", "2": "Informal comparison with international programs without systematic methodology.", "3": "Formal benchmark with at least 3 international programs in same field.", "4": "Annual benchmark with top-ranked programs; gaps addressed in curriculum updates.", "5": "Active membership in international academic networks; joint curriculum development with foreign universities."}'::jsonb),

((SELECT id FROM factors WHERE code='F2.1'), 'CR2.1.3',
'Employer participation in curriculum design',
'Employers actively participate in the design and review of academic programs.',
'Upload: Employer advisory committee records, curriculum review meeting minutes with employer attendees.',
33.33, 3,
'{"1": "Employers have no role in curriculum design.", "2": "Employers consulted informally but not in formal curriculum review process.", "3": "Employer advisory committee participates in annual curriculum review.", "4": "Employers co-design competency profiles and validate curriculum content.", "5": "Employers as co-owners of curriculum with co-investment in program delivery and student projects."}'::jsonb),

-- F2.2 Competency-Based Design
((SELECT id FROM factors WHERE code='F2.2'), 'CR2.2.1',
'Professional competency profiles defined',
'Each program has a defined graduate competency profile aligned with professional standards.',
'Upload: Competency profiles per program, validation documents.',
33.33, 1,
'{"1": "No competency profiles defined.", "2": "Competency profiles exist but are generic or not validated.", "3": "Competency profiles defined per program and validated with employers.", "4": "Competency profiles aligned with international professional standards and updated every 2 years.", "5": "Competency profiles co-created with industry, government, and alumni; integrated into all program activities."}'::jsonb),

((SELECT id FROM factors WHERE code='F2.2'), 'CR2.2.2',
'Curriculum mapped to competencies',
'All courses are mapped to the graduate competency profile showing contribution to each competency.',
'Upload: Curriculum mapping matrices, course-competency alignment tables.',
33.33, 2,
'{"1": "No curriculum mapping to competencies.", "2": "Partial mapping of some courses to competencies.", "3": "Full curriculum map showing each course contribution to competency profile.", "4": "Curriculum map used to identify gaps and is updated with each curriculum revision.", "5": "Dynamic curriculum map with learning analytics showing actual competency attainment per student."}'::jsonb),

((SELECT id FROM factors WHERE code='F2.2'), 'CR2.2.3',
'Soft skills integrated in curriculum',
'Communication, leadership, teamwork, and critical thinking are explicitly integrated in the curriculum.',
'Upload: Syllabi showing soft skill objectives, assessment methods for soft skills.',
33.33, 3,
'{"1": "No explicit soft skill integration in curriculum.", "2": "Soft skills mentioned in some courses but without systematic assessment.", "3": "Soft skills integrated with specific learning objectives and assessment rubrics.", "4": "Dedicated soft skill development program complementing academic curriculum.", "5": "Verified soft skill attainment as graduation requirement with employer validation."}'::jsonb),

-- F2.3 Curriculum Update
((SELECT id FROM factors WHERE code='F2.3'), 'CR2.3.1',
'Regular curriculum review process',
'Formal curriculum review process conducted periodically with documented outcomes.',
'Upload: Curriculum review policy, review committee records, curriculum change logs.',
33.33, 1,
'{"1": "No formal curriculum review process.", "2": "Curriculum reviewed irregularly without formal process.", "3": "Formal curriculum review every 2-3 years with documented process.", "4": "Annual curriculum review with trigger-based updates when market signals identified.", "5": "Continuous curriculum improvement cycle with semester-level micro-updates based on real-time feedback."}'::jsonb),

((SELECT id FROM factors WHERE code='F2.3'), 'CR2.3.2',
'Technology and emerging trends integration',
'Curriculum incorporates emerging technologies and current industry trends.',
'Upload: Syllabi with technology content, industry trend reports used in curriculum design.',
33.33, 2,
'{"1": "No integration of emerging technologies in curriculum.", "2": "Technology topics mentioned but not systematically updated.", "3": "Annual technology update in relevant courses based on industry input.", "4": "Technology roadmap drives curriculum updates; industry experts deliver content.", "5": "Students work with cutting-edge tools; institution has technology partnership agreements."}'::jsonb),

((SELECT id FROM factors WHERE code='F2.3'), 'CR2.3.3',
'Adaptation to labor market changes',
'Curriculum is adapted promptly when significant labor market changes are identified.',
'Upload: Examples of curriculum adaptations triggered by market changes, timeline of changes.',
33.33, 3,
'{"1": "Curriculum does not respond to labor market changes.", "2": "Changes made reactively after significant delay (>2 years).", "3": "Curriculum updated within 12 months of identified market change.", "4": "Fast-track update process allows new content within one semester.", "5": "Modular curriculum design enables real-time content updates without full revision cycle."}'::jsonb),

-- COMPONENT 3: Quality of Teaching Process
-- F3.1 Learning Methodologies
((SELECT id FROM factors WHERE code='F3.1'), 'CR3.1.1',
'Active learning methodologies used',
'Faculty systematically use active learning approaches (PBL, case studies, simulations).',
'Upload: Teaching methodology policy, faculty training records, sample syllabi with methodology descriptions.',
33.33, 1,
'{"1": "Predominantly lecture-based teaching with no active learning.", "2": "Some faculty use active learning informally.", "3": "Active learning is institutional policy; faculty trained and monitored.", "4": "Active learning in >70% of courses verified through classroom observation.", "5": "Active learning ecosystem with student-led projects, industry challenges, and verified outcomes."}'::jsonb),

((SELECT id FROM factors WHERE code='F3.1'), 'CR3.1.2',
'Problem-based and project-based learning',
'Programs incorporate problem-based or project-based learning with real-world cases.',
'Upload: Project descriptions, company partners, student deliverables examples.',
33.33, 2,
'{"1": "No problem-based or project-based learning.", "2": "Isolated projects in some courses without real-world connection.", "3": "Formal PBL/PjBL in at least 30% of courses with real company cases.", "4": "Capstone projects with company sponsors in all programs; assessed by industry panel.", "5": "All programs structured around real-world challenges; companies co-evaluate student work."}'::jsonb),

((SELECT id FROM factors WHERE code='F3.1'), 'CR3.1.3',
'Integration of real professional contexts',
'Teaching activities integrate real professional contexts and current industry challenges.',
'Upload: Industry speaker records, company visit logs, real-case teaching materials.',
33.33, 3,
'{"1": "Teaching disconnected from professional practice.", "2": "Occasional industry speakers or visits.", "3": "Systematic integration of professional contexts in at least 50% of programs.", "4": "Industry professionals co-teach in key courses; real challenges used as course content.", "5": "Students embedded in companies as part of regular coursework; industry co-designs assessments."}'::jsonb),

-- F3.2 Learning Assessment
((SELECT id FROM factors WHERE code='F3.2'), 'CR3.2.1',
'Competency-based assessment system',
'Assessment system evaluates competency attainment, not just knowledge recall.',
'Upload: Assessment policy, rubrics per competency, sample assessments.',
33.33, 1,
'{"1": "Assessment focused exclusively on knowledge recall (exams).", "2": "Some performance-based assessments but no systematic competency framework.", "3": "Competency-based assessment policy implemented across all programs.", "4": "Portfolio assessment system tracking competency development over time.", "5": "Competency attainment verified by external assessors including employers."}'::jsonb),

((SELECT id FROM factors WHERE code='F3.2'), 'CR3.2.2',
'Authentic assessments used',
'Assessment tasks reflect real professional challenges and contexts.',
'Upload: Sample authentic assessment tasks, rubrics, student work examples.',
33.33, 2,
'{"1": "No authentic assessments; all evaluations are traditional exams.", "2": "Some authentic tasks but not systematically designed.", "3": "Authentic assessments in at least 40% of courses with defined rubrics.", "4": "Authentic assessments linked to industry standards; evaluated by mixed panels.", "5": "All assessments are authentic; students present to employer panels; results inform hiring."}'::jsonb),

((SELECT id FROM factors WHERE code='F3.2'), 'CR3.2.3',
'Effective feedback mechanisms',
'Students receive timely, specific, and actionable feedback on their performance.',
'Upload: Feedback policy, student satisfaction surveys on feedback quality, feedback examples.',
33.33, 3,
'{"1": "No systematic feedback beyond grades.", "2": "Feedback provided but delayed or generic.", "3": "Feedback policy requires specific written feedback within 1 week of assessment.", "4": "Multi-source feedback including peer assessment; tracked in learning management system.", "5": "AI-assisted feedback system providing instant personalized guidance; student satisfaction >85%."}'::jsonb),

-- F3.3 Educational Technology
((SELECT id FROM factors WHERE code='F3.3'), 'CR3.3.1',
'Robust Learning Management System',
'Institution has and actively uses a robust LMS supporting all programs.',
'Upload: LMS platform name, usage statistics, faculty and student adoption rates.',
33.33, 1,
'{"1": "No LMS or only basic file sharing.", "2": "LMS exists but used primarily for document storage.", "3": "LMS actively used for course delivery, assignments, and communication.", "4": "LMS integrated with assessment tools, analytics, and student services.", "5": "Advanced LMS with AI recommendations, learning analytics, and employer portal integration."}'::jsonb),

((SELECT id FROM factors WHERE code='F3.3'), 'CR3.3.2',
'Digital learning resources',
'Programs provide quality digital learning resources beyond traditional textbooks.',
'Upload: Digital resource catalog, database subscriptions, OER usage, multimedia content inventory.',
33.33, 2,
'{"1": "Only printed textbooks; no digital resources.", "2": "Basic digital resources (e-books, PDFs) available.", "3": "Comprehensive digital library with databases, videos, and interactive content.", "4": "Custom digital content developed by faculty; industry databases provided.", "5": "Personalized digital learning paths; AI-curated resources; student-created content library."}'::jsonb),

((SELECT id FROM factors WHERE code='F3.3'), 'CR3.3.3',
'Learning analytics implemented',
'Institution uses learning analytics to monitor student progress and prevent dropout.',
'Upload: Analytics reports, early warning system documentation, intervention records.',
33.33, 3,
'{"1": "No learning analytics; student at-risk identification is reactive.", "2": "Basic tracking of grades and attendance.", "3": "Early warning system identifies at-risk students; tutoring triggered automatically.", "4": "Predictive analytics model with proven dropout reduction results.", "5": "Individual learning analytics driving personalized intervention; outcomes improvement documented."}'::jsonb),

-- COMPONENT 4: Student Development
-- F4.1 Academic Support
((SELECT id FROM factors WHERE code='F4.1'), 'CR4.1.1',
'Academic tutoring program',
'Systematic academic tutoring program available to all students.',
'Upload: Tutoring program description, attendance records, student satisfaction surveys.',
33.33, 1,
'{"1": "No academic tutoring program.", "2": "Informal tutoring available on request.", "3": "Structured tutoring program with trained tutors and scheduled sessions.", "4": "Proactive tutoring triggered by learning analytics; attendance tracked.", "5": "Comprehensive tutoring ecosystem (peer, faculty, AI) with documented academic improvement results."}'::jsonb),

((SELECT id FROM factors WHERE code='F4.1'), 'CR4.1.2',
'Professional mentoring program',
'Students have access to professional mentoring from industry practitioners.',
'Upload: Mentor database, matching process, mentoring activity records, student feedback.',
33.33, 2,
'{"1": "No professional mentoring program.", "2": "Informal mentoring without structured program.", "3": "Formal mentoring program with industry mentors matched to students.", "4": "Mentoring program with >50% student participation and tracked professional outcomes.", "5": "Alumni and industry mentor network actively developing student careers; job placement outcomes documented."}'::jsonb),

((SELECT id FROM factors WHERE code='F4.1'), 'CR4.1.3',
'Student retention programs',
'Institution has active programs to support student retention and timely graduation.',
'Upload: Retention rate data, intervention programs, dropout prevention results.',
33.33, 3,
'{"1": "No retention programs; high dropout rates unaddressed.", "2": "Basic financial aid but no academic or social support for retention.", "3": "Multi-component retention program addressing academic, financial, and social factors.", "4": "Retention rate above national average with documented improvement trajectory.", "5": "Retention rate in top quartile nationally; model program with documented replication potential."}'::jsonb),

-- F4.2 Transversal Skills Development
((SELECT id FROM factors WHERE code='F4.2'), 'CR4.2.1',
'Leadership development program',
'Structured program developing student leadership skills.',
'Upload: Leadership program curriculum, participant records, alumni leadership outcomes.',
33.33, 1,
'{"1": "No leadership development program.", "2": "Occasional leadership workshops without systematic program.", "3": "Formal leadership program available to all students with assessed outcomes.", "4": "Leadership certification program with external validation and employer recognition.", "5": "Leadership development integrated in all programs; alumni leadership positions tracked and reported."}'::jsonb),

((SELECT id FROM factors WHERE code='F4.2'), 'CR4.2.2',
'Communication skills development',
'Programs systematically develop oral and written communication skills.',
'Upload: Communication curriculum components, assessment rubrics, portfolio examples.',
33.33, 2,
'{"1": "Communication skills not explicitly developed.", "2": "Communication addressed in some courses without systematic approach.", "3": "Communication development integrated across programs with assessed milestones.", "4": "Communication portfolio required for graduation; assessed by external panel.", "5": "Communication excellence program with industry recognition and verified career impact."}'::jsonb),

((SELECT id FROM factors WHERE code='F4.2'), 'CR4.2.3',
'Teamwork and collaboration skills',
'Students develop effective teamwork skills through structured collaborative experiences.',
'Upload: Team project structures, peer evaluation rubrics, employer feedback on teamwork.',
33.33, 3,
'{"1": "No structured teamwork development.", "2": "Group projects exist but without teamwork skill assessment.", "3": "Teamwork competency assessed in at least 50% of programs.", "4": "Cross-disciplinary team projects; employer-evaluated team performance.", "5": "International virtual teams; diversity-focused collaboration; employer co-assessment verified."}'::jsonb),

-- F4.3 Practical Experience
((SELECT id FROM factors WHERE code='F4.3'), 'CR4.3.1',
'Professional internship program',
'Mandatory or structured professional internship program in all programs.',
'Upload: Internship policy, partner company list, student internship reports, employer evaluations.',
33.33, 1,
'{"1": "No internship program.", "2": "Optional internships without institutional support.", "3": "Structured internship program with supervision, defined competencies, and evaluation.", "4": "Mandatory internships in all programs; employer network with >50 active partners.", "5": "Paid internship guarantee program; internship-to-job conversion rate tracked and >40%."}'::jsonb),

((SELECT id FROM factors WHERE code='F4.3'), 'CR4.3.2',
'Industry projects and challenges',
'Students work on real industry projects as part of their academic program.',
'Upload: Project descriptions, company MoUs, student deliverables, company feedback.',
33.33, 2,
'{"1": "No industry projects.", "2": "Occasional industry projects without formal structure.", "3": "Industry projects in at least one course per program per year.", "4": "Capstone projects with company sponsors; companies evaluate and may hire students.", "5": "Students solve real company challenges for credit; IP agreements with industry partners."}'::jsonb),

((SELECT id FROM factors WHERE code='F4.3'), 'CR4.3.3',
'Laboratories and simulation facilities',
'Institution provides adequate laboratories, studios, or simulation environments for practical learning.',
'Upload: Lab inventory, usage statistics, industry-equivalent equipment documentation.',
33.33, 3,
'{"1": "No labs or severely outdated facilities.", "2": "Basic labs exist but with limited capacity or outdated equipment.", "3": "Adequate labs meeting minimum professional standards for all programs.", "4": "Labs equipped to professional industry standards; regular equipment updates.", "5": "State-of-art simulation facilities; industry-certified environments; shared with industry partners."}'::jsonb),

-- COMPONENT 5: Research & Innovation
-- F5.1 Scientific Production
((SELECT id FROM factors WHERE code='F5.1'), 'CR5.1.1',
'Indexed publications output',
'Faculty produce and publish research in indexed academic journals.',
'Upload: Publication list (last 3 years), journal rankings, citation metrics.',
33.33, 1,
'{"1": "No indexed publications.", "2": "Fewer than 5 indexed publications per year institution-wide.", "3": "Consistent indexed publication output (≥10/year); Scopus or WoS indexed.", "4": "Growing publication output with impact factor tracking; collaborative publications.", "5": "Research excellence with H-index tracking; publications in Q1/Q2 journals; citation impact documented."}'::jsonb),

((SELECT id FROM factors WHERE code='F5.1'), 'CR5.1.2',
'Active research projects',
'Institution has active, funded research projects.',
'Upload: Research project registry, funding sources, project status reports.',
33.33, 2,
'{"1": "No formal research projects.", "2": "Research projects exist but unfunded or in early stages.", "3": "Active funded research projects; at least one per faculty department.", "4": "Competitive external funding obtained; multi-year research programs established.", "5": "Major research grants; international collaborations; research centers established."}'::jsonb),

((SELECT id FROM factors WHERE code='F5.1'), 'CR5.1.3',
'Student participation in research',
'Students actively participate in research projects and present findings.',
'Upload: Student research participation records, co-authored publications, conference presentations.',
33.33, 3,
'{"1": "Students have no research participation.", "2": "Isolated student research assistantships without formal program.", "3": "Formal undergraduate/graduate research program with defined participation metrics.", "4": "Students co-author publications; research integrated in curriculum.", "5": "Students lead research projects; dedicated research scholarships; conference presentation support."}'::jsonb),

-- F5.2 Innovation & Transfer
((SELECT id FROM factors WHERE code='F5.2'), 'CR5.2.1',
'Patents and intellectual property',
'Institution generates patents or other intellectual property.',
'Upload: Patent registry, IP policy, licensing agreements.',
33.33, 1,
'{"1": "No IP policy or patents.", "2": "IP policy exists but no patents filed.", "3": "At least one patent filed in last 3 years; IP office functional.", "4": "Active patent portfolio with licensing income; IP strategy aligned with research agenda.", "5": "Patent output recognized at national level; licensing revenue supports research; industry partnerships for IP development."}'::jsonb),

((SELECT id FROM factors WHERE code='F5.2'), 'CR5.2.2',
'Spin-off and startup creation',
'Institution supports and tracks creation of spin-offs and student startups.',
'Upload: Incubator program, spin-off registry, startup funding secured, jobs created.',
33.33, 2,
'{"1": "No entrepreneurship or spin-off support.", "2": "Basic entrepreneurship courses without incubation support.", "3": "Business incubator operational; at least 2 active spin-offs.", "4": "Incubator with external funding; spin-offs generating revenue; ecosystem partnerships.", "5": "Accelerator with venture funding; nationally recognized entrepreneurship ecosystem; alumni unicorns."}'::jsonb),

((SELECT id FROM factors WHERE code='F5.2'), 'CR5.2.3',
'Industry-funded research projects',
'Research activities include industry-funded or co-developed projects.',
'Upload: Industry research contracts, funding amounts, deliverables, company satisfaction.',
33.33, 3,
'{"1": "No industry-funded research.", "2": "Occasional industry consultancy without formal research contracts.", "3": "At least 2 active industry research contracts.", "4": "Industry research portfolio representing >20% of research budget.", "5": "Strategic research partnerships with major industry players; joint R&D centers."}'::jsonb),

-- F5.3 Applied Research
((SELECT id FROM factors WHERE code='F5.3'), 'CR5.3.1',
'Research addresses real-world problems',
'Research agenda prioritizes problems relevant to regional and national development.',
'Upload: Research agenda document, problem statement alignment with national priorities.',
33.33, 1,
'{"1": "Research agenda disconnected from real-world problems.", "2": "Some applied research but without strategic alignment.", "3": "Research agenda explicitly aligned with regional or national development priorities.", "4": "Research outcomes adopted by public or private sector organizations.", "5": "Institution recognized as center of excellence for applied research in priority areas."}'::jsonb),

((SELECT id FROM factors WHERE code='F5.3'), 'CR5.3.2',
'Industry collaboration in research',
'Research projects developed in collaboration with industry partners.',
'Upload: Collaboration agreements, joint publications, industry co-investigator records.',
33.33, 2,
'{"1": "No industry collaboration in research.", "2": "Informal industry collaboration without formal agreements.", "3": "Formal research collaboration with at least 3 industry partners.", "4": "Joint research teams with industry; co-publication and co-patent outputs.", "5": "Strategic research alliance with major industry; shared facilities and resources."}'::jsonb),

((SELECT id FROM factors WHERE code='F5.3'), 'CR5.3.3',
'Research outcomes applied to teaching',
'Research findings are systematically integrated into teaching and curriculum.',
'Upload: Examples of research-informed curriculum updates, faculty research-teaching integration records.',
33.33, 3,
'{"1": "Research and teaching are completely separate.", "2": "Occasional integration of research findings in teaching.", "3": "Policy requiring research integration in at least 30% of advanced courses.", "4": "Research-based courses where students replicate or extend faculty research.", "5": "All programs enriched by ongoing research; students contribute to faculty research agenda."}'::jsonb),

-- COMPONENT 6: Engagement with the Environment
-- F6.1 Employer Relations
((SELECT id FROM factors WHERE code='F6.1'), 'CR6.1.1',
'Employer advisory council active',
'Functioning employer advisory council with regular meetings and documented outcomes.',
'Upload: Advisory council charter, member list, meeting minutes (last 12 months), action items.',
33.33, 1,
'{"1": "No employer advisory council.", "2": "Advisory council exists on paper but rarely meets.", "3": "Advisory council meets at least twice a year with documented recommendations.", "4": "Advisory council recommendations tracked and implemented; impact measured.", "5": "Strategic employer board with C-level executives; co-invests in programs and facilities."}'::jsonb),

((SELECT id FROM factors WHERE code='F6.1'), 'CR6.1.2',
'Company partnership agreements',
'Formal partnership agreements with companies for internships, projects, and hiring.',
'Upload: Partnership agreement list, MoU copies, active partnership activities.',
33.33, 2,
'{"1": "No formal company partnerships.", "2": "Informal relationships with some companies.", "3": "Formal MoUs with at least 20 companies for internships and projects.", "4": "Strategic partnerships with >50 companies; multi-year commitments.", "5": "Corporate university partnerships; companies co-invest in facilities and scholarships."}'::jsonb),

((SELECT id FROM factors WHERE code='F6.1'), 'CR6.1.3',
'Graduate recruitment programs',
'Institution actively connects graduates with employers through structured recruitment programs.',
'Upload: Career fair records, job placement rates, employer recruitment visits.',
33.33, 3,
'{"1": "No graduate recruitment support.", "2": "Job board available but no active employer engagement.", "3": "Annual career fair with >20 employers; placement support services.", "4": "Dedicated career center with individual counseling; >50% placement within 6 months.", "5": "Guaranteed interview program; employer in-campus hiring; placement rate >80% within 3 months."}'::jsonb),

-- F6.2 Continuing Education
((SELECT id FROM factors WHERE code='F6.2'), 'CR6.2.1',
'Professional update programs for graduates',
'Institution offers continuing education programs for its graduates and professionals.',
'Upload: Continuing education catalog, enrollment numbers, employer sponsorship evidence.',
33.33, 1,
'{"1": "No continuing education programs.", "2": "Occasional workshops without systematic program.", "3": "Formal continuing education catalog with at least 5 programs per year.", "4": "Employer-sponsored continuing education programs; company subscriptions.", "5": "Corporate university model; customized executive education; recognized nationally."}'::jsonb),

((SELECT id FROM factors WHERE code='F6.2'), 'CR6.2.2',
'Executive education programs',
'Institution offers executive or leadership development programs for working professionals.',
'Upload: Executive program portfolio, participant profiles, company client list.',
33.33, 2,
'{"1": "No executive education.", "2": "Basic professional courses without executive-level content.", "3": "At least 2 executive education programs per year with senior participant profile.", "4": "Corporate client list for executive education; customized programs for companies.", "5": "Top-ranked executive education; C-suite participants; international delivery."}'::jsonb),

((SELECT id FROM factors WHERE code='F6.2'), 'CR6.2.3',
'Alumni engagement and lifelong learning',
'Alumni actively engage with the institution through learning and professional networks.',
'Upload: Alumni association records, alumni event attendance, alumni learning participation.',
33.33, 3,
'{"1": "No alumni engagement program.", "2": "Alumni database exists but minimal engagement.", "3": "Active alumni association with annual events and professional network.", "4": "Alumni mentoring program; alumni contribute to curriculum; alumni hiring network.", "5": "Alumni ecosystem with investment in institution; alumni board; global alumni network active."}'::jsonb),

-- F6.3 Social Responsibility
((SELECT id FROM factors WHERE code='F6.3'), 'CR6.3.1',
'Community engagement projects',
'Institution implements social responsibility projects benefiting the local community.',
'Upload: Community project portfolio, beneficiary counts, student participation records.',
33.33, 1,
'{"1": "No community engagement.", "2": "Occasional isolated community activities.", "3": "Systematic community engagement program with documented impact.", "4": "Community partnerships with measurable social outcomes; student credit for engagement.", "5": "Institution recognized for social impact; community development center; national recognition."}'::jsonb),

((SELECT id FROM factors WHERE code='F6.3'), 'CR6.3.2',
'Regional economic impact',
'Institution contributes to regional economic development through graduates, research, and services.',
'Upload: Economic impact studies, regional employment statistics, industry development contributions.',
33.33, 2,
'{"1": "No documented regional economic impact.", "2": "Anecdotal evidence of economic contribution.", "3": "Economic impact study completed; graduates employed regionally tracked.", "4": "Institution recognized as economic anchor; contributes to regional development plans.", "5": "Major regional economic driver; policy influence; cluster development leadership."}'::jsonb),

((SELECT id FROM factors WHERE code='F6.3'), 'CR6.3.3',
'Environmental sustainability practices',
'Institution implements and promotes environmental sustainability in operations and curriculum.',
'Upload: Sustainability policy, green campus metrics, sustainability curriculum content.',
33.33, 3,
'{"1": "No sustainability practices or policies.", "2": "Basic recycling or energy practices without formal policy.", "3": "Formal sustainability policy with operational targets and annual reporting.", "4": "Sustainability integrated in curriculum; campus carbon footprint tracked and reduced.", "5": "Carbon neutral commitment; sustainability research center; national sustainability recognition."}'::jsonb),

-- COMPONENT 7: Graduate Outcomes & Impact (Core Component)
-- F7.1 Graduate Employability
((SELECT id FROM factors WHERE code='F7.1'), 'CR7.1.1',
'Graduate employment rate at 6 months',
'Percentage of graduates employed in relevant positions within 6 months of graduation.',
'Upload: Graduate tracking survey methodology, survey results (last 3 cohorts), validation process.',
33.33, 1,
'{"1": "No graduate tracking; employment rate unknown.", "2": "Employment tracked informally; rate below 50% or data incomplete.", "3": "Formal tracking system; employment rate 50-70% at 6 months.", "4": "Robust tracking system; employment rate 70-85% at 6 months.", "5": "Employment rate >85% at 6 months; verified through employer confirmation; trend improving."}'::jsonb),

((SELECT id FROM factors WHERE code='F7.1'), 'CR7.1.2',
'Graduate employment rate at 12 months',
'Percentage of graduates employed in relevant positions within 12 months of graduation.',
'Upload: 12-month graduate tracking results, job relevance assessment methodology.',
33.33, 2,
'{"1": "No 12-month tracking.", "2": "12-month tracking exists; rate below 60% or data unreliable.", "3": "12-month employment rate 60-75% in field-relevant positions.", "4": "12-month employment rate 75-90% in field-relevant positions.", "5": "12-month employment rate >90%; salary premium documented; career trajectory tracked."}'::jsonb),

((SELECT id FROM factors WHERE code='F7.1'), 'CR7.1.3',
'Graduate salary levels',
'Graduate salaries are competitive relative to regional market benchmarks.',
'Upload: Salary survey results, market benchmark comparison, methodology.',
33.33, 3,
'{"1": "No salary data collected.", "2": "Salary data collected but below market average.", "3": "Graduate salaries at or near regional market average.", "4": "Graduate salaries 10-20% above market average for same role and experience.", "5": "Graduate salaries consistently above market; premium tracked and attributed to degree."}'::jsonb),

-- F7.2 Professional Development
((SELECT id FROM factors WHERE code='F7.2'), 'CR7.2.1',
'Graduate promotion and career advancement',
'Graduates achieve professional advancement and promotions in their organizations.',
'Upload: Career progression surveys, alumni career milestone tracking, employer feedback.',
33.33, 1,
'{"1": "No career advancement data.", "2": "Anecdotal evidence of graduate promotions.", "3": "Career advancement tracked; majority of surveyed alumni report promotions within 3 years.", "4": "Graduates in leadership positions documented; career acceleration rate above peers.", "5": "Alumni in C-suite and senior leadership tracked; institution recognized for leadership pipeline."}'::jsonb),

((SELECT id FROM factors WHERE code='F7.2'), 'CR7.2.2',
'Graduate leadership in organizations',
'Graduates hold leadership positions in their organizations or sectors.',
'Upload: Alumni leadership survey, notable alumni in leadership, employer recognition.',
33.33, 2,
'{"1": "No data on graduate leadership positions.", "2": "Some alumni in leadership identified anecdotally.", "3": "Annual alumni survey tracking leadership positions; >20% in management roles.", "4": "Alumni leadership map updated annually; recognized sector leaders identified.", "5": "Alumni in national and international leadership positions; institution recognized as leadership source."}'::jsonb),

((SELECT id FROM factors WHERE code='F7.2'), 'CR7.2.3',
'Graduate entrepreneurship and business creation',
'Graduates create businesses and contribute to economic development.',
'Upload: Alumni entrepreneurship survey, business creation data, jobs created by alumni ventures.',
33.33, 3,
'{"1": "No entrepreneurship tracking among graduates.", "2": "Some alumni entrepreneurs identified without systematic tracking.", "3": "Annual entrepreneurship survey; >10% alumni in entrepreneurial ventures.", "4": "Alumni venture portfolio tracked; jobs created and revenue generated documented.", "5": "Alumni startups achieving scale; institution recognized as entrepreneurship source; alumni invest in institution."}'::jsonb),

-- F7.3 Employer Satisfaction
((SELECT id FROM factors WHERE code='F7.3'), 'CR7.3.1',
'Employer satisfaction surveys conducted',
'Regular employer satisfaction surveys assess graduate performance in the workplace.',
'Upload: Employer survey methodology, survey results (last 2 years), response rates.',
33.33, 1,
'{"1": "No employer satisfaction surveys.", "2": "Occasional informal employer feedback without systematic survey.", "3": "Annual employer survey with >50 responses; results analyzed and reported.", "4": "Bi-annual employer survey; satisfaction rate >75%; results drive curriculum improvements.", "5": "Continuous employer feedback system; satisfaction rate >85%; real-time dashboard."}'::jsonb),

((SELECT id FROM factors WHERE code='F7.3'), 'CR7.3.2',
'Graduate competency assessment by employers',
'Employers assess specific competencies of graduates from the institution.',
'Upload: Employer competency assessment tools, results by competency area, benchmark comparison.',
33.33, 2,
'{"1": "Employers not asked to assess specific competencies.", "2": "General satisfaction asked but not competency-specific.", "3": "Competency-specific employer assessment conducted; gaps identified.", "4": "Competency assessment results drive targeted curriculum improvements; improvements verified.", "5": "Employers co-design competency standards; assessment results publicly reported."}'::jsonb),

((SELECT id FROM factors WHERE code='F7.3'), 'CR7.3.3',
'Graduate re-hiring and recommendation rate',
'Employers re-hire graduates from the institution and recommend it to peers.',
'Upload: Re-hire rate data, employer Net Promoter Score, referral tracking.',
33.33, 3,
'{"1": "No re-hire or recommendation data.", "2": "Anecdotal employer recommendations without data.", "3": "Re-hire rate tracked; >50% of surveyed employers have re-hired.", "4": "Re-hire rate >70%; employer NPS tracked and positive.", "5": "Re-hire rate >85%; top employer choice; employer NPS in excellence range."}'::jsonb),

-- COMPONENT 8: Quality Assurance System
-- F8.1 Institutional Evaluation
((SELECT id FROM factors WHERE code='F8.1'), 'CR8.1.1',
'Faculty evaluation system',
'Systematic faculty evaluation covering teaching quality, research, and professional development.',
'Upload: Faculty evaluation policy, evaluation instruments, results summary, improvement actions.',
33.33, 1,
'{"1": "No faculty evaluation system.", "2": "Basic student satisfaction surveys without systematic faculty evaluation.", "3": "Multi-source faculty evaluation (students, peers, self) conducted annually.", "4": "Faculty evaluation linked to development plans and performance incentives.", "5": "360-degree faculty evaluation with employer input; results drive institutional HR decisions."}'::jsonb),

((SELECT id FROM factors WHERE code='F8.1'), 'CR8.1.2',
'Curriculum evaluation process',
'Formal curriculum evaluation process assessing effectiveness and relevance.',
'Upload: Curriculum evaluation methodology, evaluation results, curriculum improvement actions.',
33.33, 2,
'{"1": "No curriculum evaluation beyond accreditation requirements.", "2": "Curriculum evaluated occasionally without systematic methodology.", "3": "Annual curriculum evaluation with multi-stakeholder input (students, employers, faculty).", "4": "Curriculum effectiveness measured by learning outcomes and employment results.", "5": "Continuous curriculum evaluation ecosystem; real-time data drives immediate improvements."}'::jsonb),

((SELECT id FROM factors WHERE code='F8.1'), 'CR8.1.3',
'Institutional self-assessment process',
'Institution conducts comprehensive self-assessment of overall institutional quality.',
'Upload: Self-assessment methodology, last self-assessment report, improvement plan.',
33.33, 3,
'{"1": "No institutional self-assessment.", "2": "Self-assessment conducted only when required for external accreditation.", "3": "Regular self-assessment (every 2-3 years) with structured methodology.", "4": "Annual self-assessment with action plan implementation tracking.", "5": "Continuous quality monitoring; self-assessment drives strategic planning; results publicly reported."}'::jsonb),

-- F8.2 Data-Driven Management
((SELECT id FROM factors WHERE code='F8.2'), 'CR8.2.1',
'Institutional data and analytics system',
'Institution has a centralized data system supporting evidence-based decision making.',
'Upload: Data system description, dashboard screenshots, data governance policy.',
33.33, 1,
'{"1": "Data scattered across departments; no integrated system.", "2": "Basic data collection but limited analysis capability.", "3": "Integrated data system with key institutional indicators dashboard.", "4": "Advanced analytics supporting predictive modeling for student success and institutional planning.", "5": "AI-powered institutional intelligence system; real-time data drives strategic decisions."}'::jsonb),

((SELECT id FROM factors WHERE code='F8.2'), 'CR8.2.2',
'Key performance indicators monitored',
'Institution monitors a defined set of KPIs aligned with its strategic objectives.',
'Upload: KPI framework document, monitoring reports (last 12 months), trend analysis.',
33.33, 2,
'{"1": "No KPI framework.", "2": "KPIs defined but monitored inconsistently.", "3": "KPI framework with monthly monitoring; results shared with leadership.", "4": "KPIs cascaded to all units; results trigger corrective actions.", "5": "Balanced scorecard with leading and lagging indicators; public KPI dashboard."}'::jsonb),

((SELECT id FROM factors WHERE code='F8.2'), 'CR8.2.3',
'Evidence-based academic decisions',
'Academic and administrative decisions are supported by data and evidence.',
'Upload: Examples of data-driven decisions, decision logs with evidence references.',
33.33, 3,
'{"1": "Decisions made based on intuition or tradition without data.", "2": "Some data consulted but not systematically used in decisions.", "3": "Data review required for major academic decisions; evidence documented.", "4": "Data governance policy; all strategic decisions require evidence base.", "5": "Learning organization culture; data literacy training for all staff; decisions routinely cite evidence."}'::jsonb),

-- F8.3 Continuous Improvement
((SELECT id FROM factors WHERE code='F8.3'), 'CR8.3.1',
'Improvement plans implemented',
'Institution develops and implements improvement plans based on evaluation results.',
'Upload: Improvement plan documents, implementation status, outcome evidence.',
33.33, 1,
'{"1": "No improvement plans developed from evaluations.", "2": "Improvement plans developed but not systematically implemented.", "3": "Improvement plans implemented with assigned responsibilities and timelines.", "4": "Improvement cycle documented; impact of improvements measured.", "5": "Continuous improvement culture; improvements implemented within quarter; impact verified."}'::jsonb),

((SELECT id FROM factors WHERE code='F8.3'), 'CR8.3.2',
'Academic quality audits',
'Regular internal or external audits of academic quality processes.',
'Upload: Audit reports, audit methodology, findings and responses.',
33.33, 2,
'{"1": "No quality audits conducted.", "2": "Audits conducted only for external accreditation purposes.", "3": "Annual internal quality audit with formal report and response.", "4": "External quality audit every 3 years supplementing internal audits.", "5": "Continuous quality audit cycle with independent external auditors; results publicly reported."}'::jsonb),

((SELECT id FROM factors WHERE code='F8.3'), 'CR8.3.3',
'Quality culture institutionalized',
'Quality improvement is embedded in institutional culture across all levels.',
'Upload: Quality culture evidence (training, recognition, communication), staff survey on quality culture.',
33.33, 3,
'{"1": "Quality seen as compliance requirement; minimal staff engagement.", "2": "Quality promoted by leadership but not embedded in operations.", "3": "Quality training for all staff; quality recognition program in place.", "4": "Quality champions in every unit; peer learning communities; quality integrated in onboarding.", "5": "Quality as core institutional value; externally recognized quality culture; benchmark for others."}'::jsonb);
