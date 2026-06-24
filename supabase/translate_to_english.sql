-- Translate all MIAC-U content to English
-- Components
UPDATE components SET name = 'Governance and Strategic Direction'       WHERE code = 'C01';
UPDATE components SET name = 'Educational Model'                        WHERE code = 'C02';
UPDATE components SET name = 'Curriculum Design'                        WHERE code = 'C03';
UPDATE components SET name = 'Teaching and Learning Process'            WHERE code = 'C04';
UPDATE components SET name = 'Faculty and Academic Talent'              WHERE code = 'C05';
UPDATE components SET name = 'Students and Holistic Development'        WHERE code = 'C06';
UPDATE components SET name = 'Research'                                  WHERE code = 'C07';
UPDATE components SET name = 'Innovation and Technology Transfer'        WHERE code = 'C08';
UPDATE components SET name = 'Community Engagement'                     WHERE code = 'C09';
UPDATE components SET name = 'Graduate Impact'                          WHERE code = 'C10';
UPDATE components SET name = 'Academic Resources'                       WHERE code = 'C11';
UPDATE components SET name = 'Institutional Quality System'             WHERE code = 'C12';

-- Factors C01
UPDATE factors SET name = 'Mission, vision and institutional purpose'   WHERE code = 'F01.1';
UPDATE factors SET name = 'Strategic planning'                          WHERE code = 'F01.2';
UPDATE factors SET name = 'Institutional governance'                    WHERE code = 'F01.3';
UPDATE factors SET name = 'Institutional management'                    WHERE code = 'F01.4';
UPDATE factors SET name = 'Ethics and institutional integrity'          WHERE code = 'F01.5';

-- Factors C02
UPDATE factors SET name = 'Pedagogical foundations'                     WHERE code = 'F02.1';
UPDATE factors SET name = 'Student-centred learning'                    WHERE code = 'F02.2';
UPDATE factors SET name = 'Competency-based education'                  WHERE code = 'F02.3';
UPDATE factors SET name = 'Experiential learning'                       WHERE code = 'F02.4';
UPDATE factors SET name = 'Pedagogical innovation'                      WHERE code = 'F02.5';

-- Factors C03
UPDATE factors SET name = 'Curricular relevance'                        WHERE code = 'F03.1';
UPDATE factors SET name = 'Curriculum structure'                        WHERE code = 'F03.2';
UPDATE factors SET name = 'Learning outcomes'                           WHERE code = 'F03.3';
UPDATE factors SET name = 'Curriculum review and updating'              WHERE code = 'F03.4';
UPDATE factors SET name = 'Curriculum internationalisation'             WHERE code = 'F03.5';

-- Factors C04
UPDATE factors SET name = 'Teaching methodologies'                      WHERE code = 'F04.1';
UPDATE factors SET name = 'Assessment of learning'                      WHERE code = 'F04.2';
UPDATE factors SET name = 'Educational technology'                      WHERE code = 'F04.3';
UPDATE factors SET name = 'Student monitoring'                          WHERE code = 'F04.4';
UPDATE factors SET name = 'Teaching improvement'                        WHERE code = 'F04.5';

-- Factors C05
UPDATE factors SET name = 'Faculty profile'                             WHERE code = 'F05.1';
UPDATE factors SET name = 'Recruitment and hiring'                      WHERE code = 'F05.2';
UPDATE factors SET name = 'Faculty development'                         WHERE code = 'F05.3';
UPDATE factors SET name = 'Faculty evaluation'                          WHERE code = 'F05.4';
UPDATE factors SET name = 'Academic output'                             WHERE code = 'F05.5';

-- Factors C06
UPDATE factors SET name = 'Admissions'                                  WHERE code = 'F06.1';
UPDATE factors SET name = 'Student retention'                           WHERE code = 'F06.2';
UPDATE factors SET name = 'Academic support'                            WHERE code = 'F06.3';
UPDATE factors SET name = 'Holistic development'                        WHERE code = 'F06.4';

-- Factors C07
UPDATE factors SET name = 'Research policy'                             WHERE code = 'F07.1';
UPDATE factors SET name = 'Scientific output'                           WHERE code = 'F07.2';
UPDATE factors SET name = 'Student participation in research'           WHERE code = 'F07.3';
UPDATE factors SET name = 'Scientific and social impact'                WHERE code = 'F07.4';

-- Factors C08
UPDATE factors SET name = 'Technological innovation'                    WHERE code = 'F08.1';
UPDATE factors SET name = 'Entrepreneurship'                            WHERE code = 'F08.2';
UPDATE factors SET name = 'Knowledge transfer'                          WHERE code = 'F08.3';
UPDATE factors SET name = 'Business incubation'                         WHERE code = 'F08.4';

-- Factors C09
UPDATE factors SET name = 'Employer relations'                          WHERE code = 'F09.1';
UPDATE factors SET name = 'Continuing education'                        WHERE code = 'F09.2';
UPDATE factors SET name = 'Social responsibility'                       WHERE code = 'F09.3';
UPDATE factors SET name = 'University outreach'                         WHERE code = 'F09.4';

-- Factors C10
UPDATE factors SET name = 'Graduate tracking'                           WHERE code = 'F10.1';
UPDATE factors SET name = 'Employability and professional impact'        WHERE code = 'F10.2';

-- Factors C11
UPDATE factors SET name = 'Infrastructure and learning resources'       WHERE code = 'F11.1';

-- Factors C12
UPDATE factors SET name = 'Quality assurance'                           WHERE code = 'F12.1';

-- Criteria F01.1
UPDATE criteria SET name = 'The institutional mission is formally defined.'                           WHERE code = 'F01.1.C01';
UPDATE criteria SET name = 'The mission is consistent with the nature of the institution.'            WHERE code = 'F01.1.C02';
UPDATE criteria SET name = 'The mission incorporates quality professional training.'                  WHERE code = 'F01.1.C03';
UPDATE criteria SET name = 'The mission incorporates social responsibility.'                          WHERE code = 'F01.1.C04';
UPDATE criteria SET name = 'The mission is known by all stakeholder groups.'                          WHERE code = 'F01.1.C05';

-- Criteria F01.2
UPDATE criteria SET name = 'A current strategic plan exists.'                                         WHERE code = 'F01.2.C01';
UPDATE criteria SET name = 'The plan contains measurable targets.'                                    WHERE code = 'F01.2.C02';
UPDATE criteria SET name = 'Targets are aligned with the mission.'                                    WHERE code = 'F01.2.C03';
UPDATE criteria SET name = 'Monitoring indicators are in place.'                                      WHERE code = 'F01.2.C04';
UPDATE criteria SET name = 'Results are reviewed on a regular basis.'                                 WHERE code = 'F01.2.C05';

-- Criteria F01.3
UPDATE criteria SET name = 'The governance structure is clearly defined.'                             WHERE code = 'F01.3.C01';
UPDATE criteria SET name = 'Responsibilities are documented.'                                         WHERE code = 'F01.3.C02';
UPDATE criteria SET name = 'Accountability mechanisms exist.'                                         WHERE code = 'F01.3.C03';
UPDATE criteria SET name = 'Relevant external stakeholders participate in governance.'                WHERE code = 'F01.3.C04';
UPDATE criteria SET name = 'Governance promotes institutional transparency.'                          WHERE code = 'F01.3.C05';

-- Criteria F01.4
UPDATE criteria SET name = 'The institution uses information for decision-making.'                    WHERE code = 'F01.4.C01';
UPDATE criteria SET name = 'Integrated management systems exist.'                                     WHERE code = 'F01.4.C02';
UPDATE criteria SET name = 'Resources are allocated strategically.'                                   WHERE code = 'F01.4.C03';
UPDATE criteria SET name = 'Institutional risk management exists.'                                    WHERE code = 'F01.4.C04';
UPDATE criteria SET name = 'Institutional performance is evaluated systematically.'                   WHERE code = 'F01.4.C05';

-- Criteria F01.5
UPDATE criteria SET name = 'An institutional code of ethics exists.'                                  WHERE code = 'F01.5.C01';
UPDATE criteria SET name = 'Anti-corruption policies are applied.'                                    WHERE code = 'F01.5.C02';
UPDATE criteria SET name = 'Academic integrity is protected.'                                         WHERE code = 'F01.5.C03';
UPDATE criteria SET name = 'Formal reporting mechanisms exist.'                                       WHERE code = 'F01.5.C04';
UPDATE criteria SET name = 'Conflicts of interest are managed appropriately.'                         WHERE code = 'F01.5.C05';

-- Criteria F02.1
UPDATE criteria SET name = 'A formal educational model exists.'                                       WHERE code = 'F02.1.C01';
UPDATE criteria SET name = 'The model is documented and accessible.'                                  WHERE code = 'F02.1.C02';
UPDATE criteria SET name = 'The model is known by academic staff.'                                    WHERE code = 'F02.1.C03';
UPDATE criteria SET name = 'The model is applied systematically.'                                     WHERE code = 'F02.1.C04';
UPDATE criteria SET name = 'The model is reviewed periodically.'                                      WHERE code = 'F02.1.C05';

-- Criteria F02.2
UPDATE criteria SET name = 'Students actively participate in their own learning process.'             WHERE code = 'F02.2.C01';
UPDATE criteria SET name = 'Autonomous learning is promoted.'                                         WHERE code = 'F02.2.C02';
UPDATE criteria SET name = 'Critical thinking is promoted.'                                           WHERE code = 'F02.2.C03';
UPDATE criteria SET name = 'Collaborative learning is promoted.'                                      WHERE code = 'F02.2.C04';
UPDATE criteria SET name = 'Metacognitive skills are developed in students.'                          WHERE code = 'F02.2.C05';

-- Criteria F02.3
UPDATE criteria SET name = 'Graduate competencies are defined.'                                       WHERE code = 'F02.3.C01';
UPDATE criteria SET name = 'Competencies are measurable.'                                             WHERE code = 'F02.3.C02';
UPDATE criteria SET name = 'Curricular alignment with competencies exists.'                           WHERE code = 'F02.3.C03';
UPDATE criteria SET name = 'Competencies respond to labour market demands.'                           WHERE code = 'F02.3.C04';
UPDATE criteria SET name = 'Competencies are systematically assessed.'                                WHERE code = 'F02.3.C05';

-- Criteria F02.4
UPDATE criteria SET name = 'Integrative projects linked to real-world problems exist.'                WHERE code = 'F02.4.C01';
UPDATE criteria SET name = 'Practical experiences are formally incorporated into the curriculum.'     WHERE code = 'F02.4.C02';
UPDATE criteria SET name = 'Real business or professional cases are used.'                            WHERE code = 'F02.4.C03';
UPDATE criteria SET name = 'Simulations and practice laboratories exist.'                             WHERE code = 'F02.4.C04';
UPDATE criteria SET name = 'Formal partnerships with companies for placements and projects exist.'    WHERE code = 'F02.4.C05';

-- Criteria F02.5
UPDATE criteria SET name = 'Active methodologies are applied (PBL, flipped classroom, design thinking, etc.).' WHERE code = 'F02.5.C01';
UPDATE criteria SET name = 'Educational technologies are used in a pertinent manner.'                 WHERE code = 'F02.5.C02';
UPDATE criteria SET name = 'Documented curricular innovation exists.'                                 WHERE code = 'F02.5.C03';
UPDATE criteria SET name = 'New methodologies are evaluated and implemented.'                         WHERE code = 'F02.5.C04';
UPDATE criteria SET name = 'Continuous improvement of teaching practice is promoted.'                 WHERE code = 'F02.5.C05';

-- Criteria F03.1
UPDATE criteria SET name = 'Programmes respond to identified social needs.'                           WHERE code = 'F03.1.C01';
UPDATE criteria SET name = 'Programmes respond to labour market demands.'                             WHERE code = 'F03.1.C02';
UPDATE criteria SET name = 'Global trends are considered in curriculum design.'                       WHERE code = 'F03.1.C03';
UPDATE criteria SET name = 'Employers participate in curriculum design and review.'                   WHERE code = 'F03.1.C04';
UPDATE criteria SET name = 'A prospective analysis of future competency requirements exists.'         WHERE code = 'F03.1.C05';

-- Criteria F03.2
UPDATE criteria SET name = 'A logical and progressive learning sequence exists.'                      WHERE code = 'F03.2.C01';
UPDATE criteria SET name = 'Interdisciplinary knowledge is integrated.'                               WHERE code = 'F03.2.C02';
UPDATE criteria SET name = 'An adequate balance between theory and practice exists.'                  WHERE code = 'F03.2.C03';
UPDATE criteria SET name = 'Applied experiences in the professional environment are included.'        WHERE code = 'F03.2.C04';
UPDATE criteria SET name = 'Integration of competencies across the programme is fostered.'           WHERE code = 'F03.2.C05';

-- Criteria F03.3
UPDATE criteria SET name = 'Learning outcomes are formally defined.'                                  WHERE code = 'F03.3.C01';
UPDATE criteria SET name = 'Learning outcomes are measurable.'                                        WHERE code = 'F03.3.C02';
UPDATE criteria SET name = 'Learning outcomes are assessable with defined instruments.'               WHERE code = 'F03.3.C03';
UPDATE criteria SET name = 'Learning outcomes are aligned with graduate competencies.'                WHERE code = 'F03.3.C04';
UPDATE criteria SET name = 'Learning outcomes are reviewed periodically.'                             WHERE code = 'F03.3.C05';

-- Criteria F03.4
UPDATE criteria SET name = 'A formal periodic curriculum review process exists.'                      WHERE code = 'F03.4.C01';
UPDATE criteria SET name = 'Technological changes are considered in curriculum updates.'              WHERE code = 'F03.4.C02';
UPDATE criteria SET name = 'Regulatory and normative changes are considered.'                         WHERE code = 'F03.4.C03';
UPDATE criteria SET name = 'External experts participate in curriculum updates.'                      WHERE code = 'F03.4.C04';
UPDATE criteria SET name = 'Implemented curriculum improvements are documented.'                      WHERE code = 'F03.4.C05';

-- Criteria F03.5
UPDATE criteria SET name = 'Global perspectives and content of international scope are included.'     WHERE code = 'F03.5.C01';
UPDATE criteria SET name = 'International references and standards appear in the curriculum.'         WHERE code = 'F03.5.C02';
UPDATE criteria SET name = 'Academic mobility for students and staff is encouraged.'                  WHERE code = 'F03.5.C03';
UPDATE criteria SET name = 'Intercultural competencies are developed in students.'                    WHERE code = 'F03.5.C04';
UPDATE criteria SET name = 'Formal international opportunities for students exist.'                   WHERE code = 'F03.5.C05';

-- Criteria F04.1
UPDATE criteria SET name = 'Teaching staff apply diverse and active methodologies.'                   WHERE code = 'F04.1.C01';
UPDATE criteria SET name = 'Methodologies are aligned with learning outcomes.'                        WHERE code = 'F04.1.C02';
UPDATE criteria SET name = 'Active student participation in class is promoted.'                       WHERE code = 'F04.1.C03';
UPDATE criteria SET name = 'Methodologies are adapted to different learning styles.'                  WHERE code = 'F04.1.C04';
UPDATE criteria SET name = 'Teaching methodologies are documented and evaluated systematically.'      WHERE code = 'F04.1.C05';

-- Criteria F04.2
UPDATE criteria SET name = 'Assessments effectively measure the declared learning outcomes.'          WHERE code = 'F04.2.C01';
UPDATE criteria SET name = 'A variety of assessment instruments exists.'                              WHERE code = 'F04.2.C02';
UPDATE criteria SET name = 'Assessment criteria are transparent and known to students.'               WHERE code = 'F04.2.C03';
UPDATE criteria SET name = 'Formative assessments are conducted throughout the academic process.'     WHERE code = 'F04.2.C04';
UPDATE criteria SET name = 'Assessment results feed into teaching improvement.'                       WHERE code = 'F04.2.C05';

-- Criteria F04.3
UPDATE criteria SET name = 'Digital learning management platforms (LMS) are used.'                   WHERE code = 'F04.3.C01';
UPDATE criteria SET name = 'Teaching staff are trained in the use of educational technology.'         WHERE code = 'F04.3.C02';
UPDATE criteria SET name = 'Digital resources are accessible to all students.'                        WHERE code = 'F04.3.C03';
UPDATE criteria SET name = 'Technology is integrated in a pedagogically relevant way.'                WHERE code = 'F04.3.C04';
UPDATE criteria SET name = 'The impact of technology on student learning is evaluated.'               WHERE code = 'F04.3.C05';

-- Criteria F04.4
UPDATE criteria SET name = 'Individual academic progress of each student is monitored.'               WHERE code = 'F04.4.C01';
UPDATE criteria SET name = 'Students at academic risk are identified early.'                          WHERE code = 'F04.4.C02';
UPDATE criteria SET name = 'Alert and early-intervention mechanisms are activated.'                   WHERE code = 'F04.4.C03';
UPDATE criteria SET name = 'Academic support tutorials are conducted systematically.'                  WHERE code = 'F04.4.C04';
UPDATE criteria SET name = 'Student performance is documented and analysed for improvement.'          WHERE code = 'F04.4.C05';

-- Criteria F04.5
UPDATE criteria SET name = 'Teaching practice observations or evaluations are conducted.'             WHERE code = 'F04.5.C01';
UPDATE criteria SET name = 'Teaching staff receive feedback on their classroom performance.'           WHERE code = 'F04.5.C02';
UPDATE criteria SET name = 'A systematic process for teaching improvement exists.'                    WHERE code = 'F04.5.C03';
UPDATE criteria SET name = 'Good pedagogical practices are shared among teaching staff.'              WHERE code = 'F04.5.C04';
UPDATE criteria SET name = 'Students evaluate the quality of teaching received.'                      WHERE code = 'F04.5.C05';

-- Criteria F05.1
UPDATE criteria SET name = 'Teaching staff hold academic qualifications appropriate to the level taught.' WHERE code = 'F05.1.C01';
UPDATE criteria SET name = 'Teaching staff have relevant professional experience in their field.'     WHERE code = 'F05.1.C02';
UPDATE criteria SET name = 'The faculty profile is documented and verifiable.'                        WHERE code = 'F05.1.C03';
UPDATE criteria SET name = 'Academic and professional suitability of teaching staff is verified.'     WHERE code = 'F05.1.C04';

-- Criteria F05.2
UPDATE criteria SET name = 'A formal and transparent faculty selection process exists.'               WHERE code = 'F05.2.C01';
UPDATE criteria SET name = 'Selection is based on defined academic and professional criteria.'        WHERE code = 'F05.2.C02';
UPDATE criteria SET name = 'Track record and references of candidates are verified.'                  WHERE code = 'F05.2.C03';
UPDATE criteria SET name = 'Contractual conditions are adequate and competitive.'                     WHERE code = 'F05.2.C04';

-- Criteria F05.3
UPDATE criteria SET name = 'A formal faculty training and professional development programme exists.' WHERE code = 'F05.3.C01';
UPDATE criteria SET name = 'Teaching staff participate in professional development activities.'        WHERE code = 'F05.3.C02';
UPDATE criteria SET name = 'Participation in conferences and academic events is funded.'              WHERE code = 'F05.3.C03';
UPDATE criteria SET name = 'Continuous pedagogical development of teaching staff is promoted.'        WHERE code = 'F05.3.C04';

-- Criteria F05.4
UPDATE criteria SET name = 'A formal faculty performance evaluation system exists.'                   WHERE code = 'F05.4.C01';
UPDATE criteria SET name = 'Evaluation considers input from students, peers and management.'          WHERE code = 'F05.4.C02';
UPDATE criteria SET name = 'Evaluation results inform individual improvement plans.'                  WHERE code = 'F05.4.C03';
UPDATE criteria SET name = 'The faculty evaluation process is transparent and widely known.'          WHERE code = 'F05.4.C04';

-- Criteria F05.5
UPDATE criteria SET name = 'Teaching staff publish research in indexed journals.'                     WHERE code = 'F05.5.C01';
UPDATE criteria SET name = 'Teaching staff participate in active research projects.'                  WHERE code = 'F05.5.C02';
UPDATE criteria SET name = 'Academic output is recognised and valued by the institution.'             WHERE code = 'F05.5.C03';
UPDATE criteria SET name = 'An incentive policy for academic intellectual output exists.'             WHERE code = 'F05.5.C04';

-- Criteria F06.1
UPDATE criteria SET name = 'Clear and transparent admissions criteria exist.'                         WHERE code = 'F06.1.C01';
UPDATE criteria SET name = 'The admissions process guarantees equal opportunity.'                     WHERE code = 'F06.1.C02';
UPDATE criteria SET name = 'The entry profile of admitted students is evaluated.'                     WHERE code = 'F06.1.C03';
UPDATE criteria SET name = 'Admissions results are communicated in a timely manner.'                  WHERE code = 'F06.1.C04';

-- Criteria F06.2
UPDATE criteria SET name = 'A system for monitoring student persistence exists.'                      WHERE code = 'F06.2.C01';
UPDATE criteria SET name = 'Causes of student dropout are identified and addressed.'                  WHERE code = 'F06.2.C02';
UPDATE criteria SET name = 'Financial support programmes for at-risk students exist.'                 WHERE code = 'F06.2.C03';
UPDATE criteria SET name = 'The student retention rate is monitored and improved.'                    WHERE code = 'F06.2.C04';

-- Criteria F06.3
UPDATE criteria SET name = 'Accessible tutoring and academic counselling services exist.'             WHERE code = 'F06.3.C01';
UPDATE criteria SET name = 'Learning support resources are available (library, laboratories).'        WHERE code = 'F06.3.C02';
UPDATE criteria SET name = 'Bridging or reinforcement programmes exist for students with difficulties.' WHERE code = 'F06.3.C03';
UPDATE criteria SET name = 'Support services are known and used by students.'                         WHERE code = 'F06.3.C04';

-- Criteria F06.4
UPDATE criteria SET name = 'Extracurricular, sports and cultural activities are promoted.'            WHERE code = 'F06.4.C01';
UPDATE criteria SET name = 'Leadership and soft-skills development programmes exist.'                 WHERE code = 'F06.4.C02';
UPDATE criteria SET name = 'Student participation in institutional life is encouraged.'               WHERE code = 'F06.4.C03';
UPDATE criteria SET name = 'Mental health and student well-being support mechanisms exist.'           WHERE code = 'F06.4.C04';

-- Criteria F07.1
UPDATE criteria SET name = 'A formal institutional research policy exists.'                           WHERE code = 'F07.1.C01';
UPDATE criteria SET name = 'Specific budget resources are allocated for research.'                    WHERE code = 'F07.1.C02';
UPDATE criteria SET name = 'An organisational structure that manages research exists.'                WHERE code = 'F07.1.C03';
UPDATE criteria SET name = 'The research policy is aligned with national and global priorities.'      WHERE code = 'F07.1.C04';

-- Criteria F07.2
UPDATE criteria SET name = 'The institution generates scientific publications in indexed journals.'   WHERE code = 'F07.2.C01';
UPDATE criteria SET name = 'Researcher-academics have active scientific output.'                      WHERE code = 'F07.2.C02';
UPDATE criteria SET name = 'Formally constituted research groups or lines exist.'                     WHERE code = 'F07.2.C03';
UPDATE criteria SET name = 'The institution participates in national and international research networks.' WHERE code = 'F07.2.C04';

-- Criteria F07.3
UPDATE criteria SET name = 'Students participate in institutional research projects.'                 WHERE code = 'F07.3.C01';
UPDATE criteria SET name = 'Student research seedbeds or groups exist.'                              WHERE code = 'F07.3.C02';
UPDATE criteria SET name = 'Student research output is recognised and rewarded.'                      WHERE code = 'F07.3.C03';
UPDATE criteria SET name = 'Students have access to funding for research projects.'                   WHERE code = 'F07.3.C04';

-- Criteria F07.4
UPDATE criteria SET name = 'Institutional research is cited in specialist literature.'                WHERE code = 'F07.4.C01';
UPDATE criteria SET name = 'The institution generates patents, registrations or intellectual property.' WHERE code = 'F07.4.C02';
UPDATE criteria SET name = 'Research contributes to solving social problems.'                         WHERE code = 'F07.4.C03';
UPDATE criteria SET name = 'Evidence of research impact on public policy exists.'                     WHERE code = 'F07.4.C04';
UPDATE criteria SET name = 'The institution receives competitive external funding for research.'       WHERE code = 'F07.4.C05';
UPDATE criteria SET name = 'Research results are transferred to society and industry.'                WHERE code = 'F07.4.C06';

-- Criteria F08.1
UPDATE criteria SET name = 'The institution actively promotes a culture of innovation.'               WHERE code = 'F08.1.C01';
UPDATE criteria SET name = 'Technological innovation projects are under development.'                 WHERE code = 'F08.1.C02';
UPDATE criteria SET name = 'Innovation methodologies are used (design thinking, agile, lean, etc.).' WHERE code = 'F08.1.C03';
UPDATE criteria SET name = 'Teaching staff and students actively participate in innovation projects.' WHERE code = 'F08.1.C04';

-- Criteria F08.2
UPDATE criteria SET name = 'A formal entrepreneurship training programme exists.'                     WHERE code = 'F08.2.C01';
UPDATE criteria SET name = 'Creation of companies by students and graduates is supported.'            WHERE code = 'F08.2.C02';
UPDATE criteria SET name = 'Resources and spaces dedicated to entrepreneurship exist.'                WHERE code = 'F08.2.C03';
UPDATE criteria SET name = 'The entrepreneurship rate among students and graduates is measured and reported.' WHERE code = 'F08.2.C04';

-- Criteria F08.3
UPDATE criteria SET name = 'Formal mechanisms for technology transfer to the productive sector exist.' WHERE code = 'F08.3.C01';
UPDATE criteria SET name = 'Consultancy and advisory services to the business sector are provided.'   WHERE code = 'F08.3.C02';
UPDATE criteria SET name = 'Collaboration agreements for knowledge transfer are generated.'           WHERE code = 'F08.3.C03';
UPDATE criteria SET name = 'Evidence of the economic impact of technology transfer exists.'           WHERE code = 'F08.3.C04';

-- Criteria F08.4
UPDATE criteria SET name = 'An institutional business incubator or co-working space exists.'         WHERE code = 'F08.4.C01';
UPDATE criteria SET name = 'The incubator has available mentors and experts.'                         WHERE code = 'F08.4.C02';
UPDATE criteria SET name = 'Incubated companies generate measurable employment and economic value.'   WHERE code = 'F08.4.C03';
UPDATE criteria SET name = 'Performance tracking metrics for incubated companies exist.'              WHERE code = 'F08.4.C04';

-- Criteria F09.1
UPDATE criteria SET name = 'Active agreements with employer companies and institutions exist.'        WHERE code = 'F09.1.C01';
UPDATE criteria SET name = 'Employers participate in curriculum design and review.'                   WHERE code = 'F09.1.C02';
UPDATE criteria SET name = 'Job fairs and employer networking events are held.'                       WHERE code = 'F09.1.C03';
UPDATE criteria SET name = 'Employer satisfaction with graduates is measured and reported.'           WHERE code = 'F09.1.C04';

-- Criteria F09.2
UPDATE criteria SET name = 'The institution offers continuing education and postgraduate programmes.' WHERE code = 'F09.2.C01';
UPDATE criteria SET name = 'Continuing education programmes respond to market needs.'                 WHERE code = 'F09.2.C02';
UPDATE criteria SET name = 'Participant satisfaction with continuing education is evaluated.'         WHERE code = 'F09.2.C03';
UPDATE criteria SET name = 'Continuing education generates value and strengthens institutional reputation.' WHERE code = 'F09.2.C04';

-- Criteria F09.3
UPDATE criteria SET name = 'A formal university social responsibility policy exists.'                 WHERE code = 'F09.3.C01';
UPDATE criteria SET name = 'Social impact projects with vulnerable communities are carried out.'      WHERE code = 'F09.3.C02';
UPDATE criteria SET name = 'Students participate in community service activities.'                    WHERE code = 'F09.3.C03';
UPDATE criteria SET name = 'The social impact of institutional activities is measured and reported.'  WHERE code = 'F09.3.C04';

-- Criteria F09.4
UPDATE criteria SET name = 'Cultural, scientific and academic events open to the community are held.' WHERE code = 'F09.4.C01';
UPDATE criteria SET name = 'The institution disseminates knowledge through public channels and media.' WHERE code = 'F09.4.C02';
UPDATE criteria SET name = 'Formally established university outreach programmes exist.'               WHERE code = 'F09.4.C03';

-- Criteria F10.1
UPDATE criteria SET name = 'A formal and active graduate tracking system exists.'                     WHERE code = 'F10.1.C01';
UPDATE criteria SET name = 'Employability at 6 months after graduation is measured.'                  WHERE code = 'F10.1.C02';
UPDATE criteria SET name = 'Employability at 12 months after graduation is measured.'                 WHERE code = 'F10.1.C03';
UPDATE criteria SET name = 'Employability at 24 months after graduation is measured.'                 WHERE code = 'F10.1.C04';
UPDATE criteria SET name = 'Graduate salary relative to the market is measured.'                      WHERE code = 'F10.1.C05';

-- Criteria F10.2
UPDATE criteria SET name = 'Career progression of graduates is measured.'                             WHERE code = 'F10.2.C01';
UPDATE criteria SET name = 'Graduate satisfaction with their education is measured.'                  WHERE code = 'F10.2.C02';
UPDATE criteria SET name = 'Employer satisfaction with graduate performance is measured.'             WHERE code = 'F10.2.C03';
UPDATE criteria SET name = 'The entrepreneurship rate among graduates is measured.'                   WHERE code = 'F10.2.C04';
UPDATE criteria SET name = 'The social impact of graduates in their communities is measured.'         WHERE code = 'F10.2.C05';

-- Criteria F11.1
UPDATE criteria SET name = 'Physical infrastructure is adequate for academic processes.'              WHERE code = 'F11.1.C01';
UPDATE criteria SET name = 'Sufficient and up-to-date digital resources exist (databases, digital library).' WHERE code = 'F11.1.C02';
UPDATE criteria SET name = 'Learning resources are accessible to all students.'                       WHERE code = 'F11.1.C03';

-- Criteria F12.1
UPDATE criteria SET name = 'A formally established institutional quality assurance system exists.'    WHERE code = 'F12.1.C01';
UPDATE criteria SET name = 'Documented evidence of continuous improvement based on evaluation results exists.' WHERE code = 'F12.1.C02';

-- Verify
SELECT 'Components' as table_name, COUNT(*) as total FROM components
UNION ALL SELECT 'Factors', COUNT(*) FROM factors
UNION ALL SELECT 'Criteria', COUNT(*) FROM criteria;
