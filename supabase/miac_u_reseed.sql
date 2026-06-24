-- ============================================================
-- MIAC-U RESEED — no hardcoded UUIDs
-- Run with "Run without RLS" in Supabase SQL Editor
-- ============================================================

ALTER TABLE components ADD COLUMN IF NOT EXISTS weight numeric DEFAULT 0;

TRUNCATE TABLE criteria CASCADE;
TRUNCATE TABLE factors CASCADE;
TRUNCATE TABLE components CASCADE;

-- ============================================================
-- COMPONENTS
-- ============================================================
INSERT INTO components (code, name, sort_order, weight) VALUES
('C01', 'Gobernanza y Dirección Estratégica',   1,  8),
('C02', 'Modelo Educativo',                      2,  8),
('C03', 'Diseño Curricular',                     3, 10),
('C04', 'Proceso de Enseñanza-Aprendizaje',      4, 12),
('C05', 'Profesores y Talento Académico',        5, 10),
('C06', 'Estudiantes y Desarrollo Integral',     6,  7),
('C07', 'Investigación',                         7,  8),
('C08', 'Innovación y Transferencia',            8,  7),
('C09', 'Vinculación con el Entorno',            9,  8),
('C10', 'Impacto de Egresados',                 10, 15),
('C11', 'Recursos Académicos',                  11,  3),
('C12', 'Sistema Institucional de Calidad',     12,  4);

-- ============================================================
-- FACTORS
-- ============================================================
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F01.1', id, 'Misión, visión y propósito institucional', 1 FROM components WHERE code = 'C01';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F01.2', id, 'Planificación estratégica', 2 FROM components WHERE code = 'C01';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F01.3', id, 'Gobernanza institucional', 3 FROM components WHERE code = 'C01';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F01.4', id, 'Gestión institucional', 4 FROM components WHERE code = 'C01';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F01.5', id, 'Ética e integridad institucional', 5 FROM components WHERE code = 'C01';

INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F02.1', id, 'Fundamentos pedagógicos', 1 FROM components WHERE code = 'C02';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F02.2', id, 'Aprendizaje centrado en el estudiante', 2 FROM components WHERE code = 'C02';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F02.3', id, 'Formación basada en competencias', 3 FROM components WHERE code = 'C02';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F02.4', id, 'Aprendizaje experiencial', 4 FROM components WHERE code = 'C02';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F02.5', id, 'Innovación pedagógica', 5 FROM components WHERE code = 'C02';

INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F03.1', id, 'Pertinencia curricular', 1 FROM components WHERE code = 'C03';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F03.2', id, 'Estructura curricular', 2 FROM components WHERE code = 'C03';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F03.3', id, 'Resultados de aprendizaje', 3 FROM components WHERE code = 'C03';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F03.4', id, 'Actualización curricular', 4 FROM components WHERE code = 'C03';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F03.5', id, 'Internacionalización curricular', 5 FROM components WHERE code = 'C03';

INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F04.1', id, 'Metodologías de enseñanza', 1 FROM components WHERE code = 'C04';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F04.2', id, 'Evaluación del aprendizaje', 2 FROM components WHERE code = 'C04';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F04.3', id, 'Tecnología educativa', 3 FROM components WHERE code = 'C04';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F04.4', id, 'Seguimiento del estudiante', 4 FROM components WHERE code = 'C04';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F04.5', id, 'Mejora de la enseñanza', 5 FROM components WHERE code = 'C04';

INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F05.1', id, 'Perfil docente', 1 FROM components WHERE code = 'C05';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F05.2', id, 'Selección y contratación', 2 FROM components WHERE code = 'C05';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F05.3', id, 'Desarrollo docente', 3 FROM components WHERE code = 'C05';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F05.4', id, 'Evaluación docente', 4 FROM components WHERE code = 'C05';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F05.5', id, 'Producción académica', 5 FROM components WHERE code = 'C05';

INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F06.1', id, 'Admisión', 1 FROM components WHERE code = 'C06';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F06.2', id, 'Retención estudiantil', 2 FROM components WHERE code = 'C06';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F06.3', id, 'Apoyo académico', 3 FROM components WHERE code = 'C06';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F06.4', id, 'Desarrollo integral', 4 FROM components WHERE code = 'C06';

INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F07.1', id, 'Política de investigación', 1 FROM components WHERE code = 'C07';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F07.2', id, 'Producción científica', 2 FROM components WHERE code = 'C07';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F07.3', id, 'Participación estudiantil en investigación', 3 FROM components WHERE code = 'C07';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F07.4', id, 'Impacto científico y social', 4 FROM components WHERE code = 'C07';

INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F08.1', id, 'Innovación tecnológica', 1 FROM components WHERE code = 'C08';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F08.2', id, 'Emprendimiento', 2 FROM components WHERE code = 'C08';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F08.3', id, 'Transferencia de conocimiento', 3 FROM components WHERE code = 'C08';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F08.4', id, 'Incubación empresarial', 4 FROM components WHERE code = 'C08';

INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F09.1', id, 'Relación con empleadores', 1 FROM components WHERE code = 'C09';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F09.2', id, 'Educación continua', 2 FROM components WHERE code = 'C09';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F09.3', id, 'Responsabilidad social', 3 FROM components WHERE code = 'C09';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F09.4', id, 'Extensión universitaria', 4 FROM components WHERE code = 'C09';

INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F10.1', id, 'Seguimiento de egresados', 1 FROM components WHERE code = 'C10';
INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F10.2', id, 'Empleabilidad e impacto profesional', 2 FROM components WHERE code = 'C10';

INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F11.1', id, 'Infraestructura y recursos de aprendizaje', 1 FROM components WHERE code = 'C11';

INSERT INTO factors (code, component_id, name, sort_order)
SELECT 'F12.1', id, 'Aseguramiento de la calidad', 1 FROM components WHERE code = 'C12';

-- ============================================================
-- CRITERIA (code = factor_code + sequential number)
-- ============================================================

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.1.C01', id, 'La misión institucional está formalmente definida.', 1 FROM factors WHERE code = 'F01.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.1.C02', id, 'La misión es coherente con la naturaleza de la institución.', 2 FROM factors WHERE code = 'F01.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.1.C03', id, 'La misión incorpora formación profesional de calidad.', 3 FROM factors WHERE code = 'F01.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.1.C04', id, 'La misión incorpora responsabilidad social.', 4 FROM factors WHERE code = 'F01.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.1.C05', id, 'La misión es conocida por los grupos de interés.', 5 FROM factors WHERE code = 'F01.1';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.2.C01', id, 'Existe un plan estratégico vigente.', 1 FROM factors WHERE code = 'F01.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.2.C02', id, 'El plan contiene metas medibles.', 2 FROM factors WHERE code = 'F01.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.2.C03', id, 'Las metas están alineadas con la misión.', 3 FROM factors WHERE code = 'F01.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.2.C04', id, 'Existen indicadores de seguimiento.', 4 FROM factors WHERE code = 'F01.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.2.C05', id, 'Los resultados son revisados periódicamente.', 5 FROM factors WHERE code = 'F01.2';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.3.C01', id, 'La estructura de gobierno está claramente definida.', 1 FROM factors WHERE code = 'F01.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.3.C02', id, 'Las responsabilidades están documentadas.', 2 FROM factors WHERE code = 'F01.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.3.C03', id, 'Existen mecanismos de rendición de cuentas.', 3 FROM factors WHERE code = 'F01.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.3.C04', id, 'Participan actores externos relevantes en la gobernanza.', 4 FROM factors WHERE code = 'F01.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.3.C05', id, 'La gobernanza promueve transparencia institucional.', 5 FROM factors WHERE code = 'F01.3';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.4.C01', id, 'La institución utiliza información para la toma de decisiones.', 1 FROM factors WHERE code = 'F01.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.4.C02', id, 'Existen sistemas integrados de gestión.', 2 FROM factors WHERE code = 'F01.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.4.C03', id, 'Los recursos son asignados estratégicamente.', 3 FROM factors WHERE code = 'F01.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.4.C04', id, 'Existe gestión de riesgos institucionales.', 4 FROM factors WHERE code = 'F01.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.4.C05', id, 'Se evalúa el desempeño institucional de forma sistemática.', 5 FROM factors WHERE code = 'F01.4';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.5.C01', id, 'Existe un código de ética institucional.', 1 FROM factors WHERE code = 'F01.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.5.C02', id, 'Existen políticas anticorrupción aplicadas.', 2 FROM factors WHERE code = 'F01.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.5.C03', id, 'Se protege la integridad académica.', 3 FROM factors WHERE code = 'F01.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.5.C04', id, 'Existen mecanismos formales de denuncia.', 4 FROM factors WHERE code = 'F01.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F01.5.C05', id, 'Se gestionan adecuadamente los conflictos de interés.', 5 FROM factors WHERE code = 'F01.5';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.1.C01', id, 'Existe un modelo educativo formal.', 1 FROM factors WHERE code = 'F02.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.1.C02', id, 'El modelo está documentado y accesible.', 2 FROM factors WHERE code = 'F02.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.1.C03', id, 'El modelo es conocido por los docentes.', 3 FROM factors WHERE code = 'F02.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.1.C04', id, 'El modelo se aplica sistemáticamente.', 4 FROM factors WHERE code = 'F02.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.1.C05', id, 'El modelo se revisa periódicamente.', 5 FROM factors WHERE code = 'F02.1';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.2.C01', id, 'El estudiante participa activamente en su proceso de aprendizaje.', 1 FROM factors WHERE code = 'F02.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.2.C02', id, 'Se promueve el aprendizaje autónomo.', 2 FROM factors WHERE code = 'F02.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.2.C03', id, 'Se promueve el pensamiento crítico.', 3 FROM factors WHERE code = 'F02.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.2.C04', id, 'Se promueve el aprendizaje colaborativo.', 4 FROM factors WHERE code = 'F02.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.2.C05', id, 'Se desarrollan habilidades metacognitivas en los estudiantes.', 5 FROM factors WHERE code = 'F02.2';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.3.C01', id, 'Las competencias del egresado están definidas.', 1 FROM factors WHERE code = 'F02.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.3.C02', id, 'Las competencias son medibles.', 2 FROM factors WHERE code = 'F02.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.3.C03', id, 'Existe alineación curricular con las competencias.', 3 FROM factors WHERE code = 'F02.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.3.C04', id, 'Las competencias responden a las demandas del mercado laboral.', 4 FROM factors WHERE code = 'F02.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.3.C05', id, 'Las competencias son evaluadas sistemáticamente.', 5 FROM factors WHERE code = 'F02.3';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.4.C01', id, 'Existen proyectos integradores vinculados a problemas reales.', 1 FROM factors WHERE code = 'F02.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.4.C02', id, 'Existen experiencias prácticas formalmente incorporadas al currículo.', 2 FROM factors WHERE code = 'F02.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.4.C03', id, 'Se utilizan casos reales de empresas o contextos profesionales.', 3 FROM factors WHERE code = 'F02.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.4.C04', id, 'Existen simulaciones y laboratorios de práctica.', 4 FROM factors WHERE code = 'F02.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.4.C05', id, 'Existe vinculación formal con empresas para prácticas y proyectos.', 5 FROM factors WHERE code = 'F02.4';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.5.C01', id, 'Se aplican metodologías activas (ABP, flipped classroom, design thinking, etc.).', 1 FROM factors WHERE code = 'F02.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.5.C02', id, 'Se utilizan tecnologías educativas de forma pertinente.', 2 FROM factors WHERE code = 'F02.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.5.C03', id, 'Existe innovación curricular documentada.', 3 FROM factors WHERE code = 'F02.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.5.C04', id, 'Se evalúan e implementan nuevas metodologías.', 4 FROM factors WHERE code = 'F02.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F02.5.C05', id, 'Se promueve la mejora continua de la práctica pedagógica.', 5 FROM factors WHERE code = 'F02.5';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.1.C01', id, 'Los programas responden a necesidades sociales identificadas.', 1 FROM factors WHERE code = 'F03.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.1.C02', id, 'Los programas responden a las demandas del mercado laboral.', 2 FROM factors WHERE code = 'F03.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.1.C03', id, 'Se consideran tendencias globales en el diseño curricular.', 3 FROM factors WHERE code = 'F03.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.1.C04', id, 'Participan empleadores en el diseño y revisión curricular.', 4 FROM factors WHERE code = 'F03.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.1.C05', id, 'Existe análisis prospectivo de competencias futuras requeridas.', 5 FROM factors WHERE code = 'F03.1';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.2.C01', id, 'Existe una secuencia lógica y progresiva de aprendizaje.', 1 FROM factors WHERE code = 'F03.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.2.C02', id, 'Se integran conocimientos interdisciplinarios.', 2 FROM factors WHERE code = 'F03.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.2.C03', id, 'Existe equilibrio adecuado entre teoría y práctica.', 3 FROM factors WHERE code = 'F03.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.2.C04', id, 'Se incluyen experiencias aplicadas en el entorno profesional.', 4 FROM factors WHERE code = 'F03.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.2.C05', id, 'Se fomenta la integración de competencias a lo largo del programa.', 5 FROM factors WHERE code = 'F03.2';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.3.C01', id, 'Los resultados de aprendizaje están formalmente definidos.', 1 FROM factors WHERE code = 'F03.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.3.C02', id, 'Los resultados de aprendizaje son medibles.', 2 FROM factors WHERE code = 'F03.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.3.C03', id, 'Los resultados de aprendizaje son evaluables con instrumentos definidos.', 3 FROM factors WHERE code = 'F03.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.3.C04', id, 'Los resultados de aprendizaje están alineados con las competencias del egresado.', 4 FROM factors WHERE code = 'F03.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.3.C05', id, 'Los resultados de aprendizaje son revisados periódicamente.', 5 FROM factors WHERE code = 'F03.3';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.4.C01', id, 'Existe un proceso formal de revisión curricular periódica.', 1 FROM factors WHERE code = 'F03.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.4.C02', id, 'Se consideran cambios tecnológicos en la actualización curricular.', 2 FROM factors WHERE code = 'F03.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.4.C03', id, 'Se consideran cambios regulatorios y normativos.', 3 FROM factors WHERE code = 'F03.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.4.C04', id, 'Participan expertos externos en la actualización curricular.', 4 FROM factors WHERE code = 'F03.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.4.C05', id, 'Se documentan las mejoras curriculares implementadas.', 5 FROM factors WHERE code = 'F03.4';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.5.C01', id, 'Se incluyen perspectivas y contenidos de alcance global.', 1 FROM factors WHERE code = 'F03.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.5.C02', id, 'Existen referencias y estándares internacionales en el currículo.', 2 FROM factors WHERE code = 'F03.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.5.C03', id, 'Se fomenta la movilidad académica de estudiantes y docentes.', 3 FROM factors WHERE code = 'F03.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.5.C04', id, 'Se desarrollan competencias interculturales en los estudiantes.', 4 FROM factors WHERE code = 'F03.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F03.5.C05', id, 'Existen oportunidades internacionales formales para estudiantes.', 5 FROM factors WHERE code = 'F03.5';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.1.C01', id, 'Los docentes aplican metodologías diversas y activas.', 1 FROM factors WHERE code = 'F04.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.1.C02', id, 'Las metodologías están alineadas con los resultados de aprendizaje.', 2 FROM factors WHERE code = 'F04.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.1.C03', id, 'Se promueve la participación activa del estudiante en clase.', 3 FROM factors WHERE code = 'F04.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.1.C04', id, 'Las metodologías se adaptan a diferentes estilos de aprendizaje.', 4 FROM factors WHERE code = 'F04.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.1.C05', id, 'Las metodologías de enseñanza se documentan y evalúan sistemáticamente.', 5 FROM factors WHERE code = 'F04.1';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.2.C01', id, 'Las evaluaciones miden efectivamente los resultados de aprendizaje declarados.', 1 FROM factors WHERE code = 'F04.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.2.C02', id, 'Existe variedad de instrumentos de evaluación.', 2 FROM factors WHERE code = 'F04.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.2.C03', id, 'Los criterios de evaluación son transparentes y conocidos por los estudiantes.', 3 FROM factors WHERE code = 'F04.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.2.C04', id, 'Se realizan evaluaciones formativas a lo largo del proceso académico.', 4 FROM factors WHERE code = 'F04.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.2.C05', id, 'Los resultados de evaluación retroalimentan la mejora de la enseñanza.', 5 FROM factors WHERE code = 'F04.2';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.3.C01', id, 'Se utilizan plataformas digitales de gestión del aprendizaje (LMS).', 1 FROM factors WHERE code = 'F04.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.3.C02', id, 'Los docentes están capacitados en el uso de tecnología educativa.', 2 FROM factors WHERE code = 'F04.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.3.C03', id, 'Los recursos digitales son accesibles para todos los estudiantes.', 3 FROM factors WHERE code = 'F04.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.3.C04', id, 'La tecnología se integra de forma pedagógicamente pertinente.', 4 FROM factors WHERE code = 'F04.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.3.C05', id, 'Se evalúa el impacto de la tecnología en el aprendizaje estudiantil.', 5 FROM factors WHERE code = 'F04.3';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.4.C01', id, 'Existe seguimiento del progreso académico individual de cada estudiante.', 1 FROM factors WHERE code = 'F04.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.4.C02', id, 'Se identifican tempranamente estudiantes en riesgo académico.', 2 FROM factors WHERE code = 'F04.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.4.C03', id, 'Existen mecanismos de alerta y atención temprana activados.', 3 FROM factors WHERE code = 'F04.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.4.C04', id, 'Se realizan tutorías de apoyo académico de forma sistemática.', 4 FROM factors WHERE code = 'F04.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.4.C05', id, 'Se documenta y analiza el rendimiento estudiantil para mejora.', 5 FROM factors WHERE code = 'F04.4';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.5.C01', id, 'Se realizan observaciones o evaluaciones de la práctica docente.', 1 FROM factors WHERE code = 'F04.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.5.C02', id, 'Los docentes reciben retroalimentación sobre su desempeño en aula.', 2 FROM factors WHERE code = 'F04.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.5.C03', id, 'Existe un proceso sistemático de mejora de la enseñanza.', 3 FROM factors WHERE code = 'F04.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.5.C04', id, 'Se comparten buenas prácticas pedagógicas entre docentes.', 4 FROM factors WHERE code = 'F04.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F04.5.C05', id, 'Los estudiantes evalúan la calidad de la enseñanza recibida.', 5 FROM factors WHERE code = 'F04.5';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.1.C01', id, 'Los docentes poseen titulación académica acorde al nivel que enseñan.', 1 FROM factors WHERE code = 'F05.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.1.C02', id, 'Los docentes tienen experiencia profesional relevante en su campo.', 2 FROM factors WHERE code = 'F05.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.1.C03', id, 'El perfil docente está documentado y es verificable.', 3 FROM factors WHERE code = 'F05.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.1.C04', id, 'Se verifica la idoneidad académica y profesional de los docentes.', 4 FROM factors WHERE code = 'F05.1';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.2.C01', id, 'Existe un proceso formal y transparente de selección de docentes.', 1 FROM factors WHERE code = 'F05.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.2.C02', id, 'La selección se basa en criterios académicos y profesionales definidos.', 2 FROM factors WHERE code = 'F05.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.2.C03', id, 'Se verifica la trayectoria y referencias de los candidatos.', 3 FROM factors WHERE code = 'F05.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.2.C04', id, 'Las condiciones de contratación son adecuadas y competitivas.', 4 FROM factors WHERE code = 'F05.2';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.3.C01', id, 'Existe un programa formal de formación y actualización docente.', 1 FROM factors WHERE code = 'F05.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.3.C02', id, 'Los docentes participan en actividades de desarrollo profesional.', 2 FROM factors WHERE code = 'F05.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.3.C03', id, 'Se financia la participación en congresos y eventos académicos.', 3 FROM factors WHERE code = 'F05.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.3.C04', id, 'Se promueve la formación pedagógica continua de los docentes.', 4 FROM factors WHERE code = 'F05.3';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.4.C01', id, 'Existe un sistema formal de evaluación del desempeño docente.', 1 FROM factors WHERE code = 'F05.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.4.C02', id, 'La evaluación considera opinión de estudiantes, pares y directivos.', 2 FROM factors WHERE code = 'F05.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.4.C03', id, 'Los resultados de la evaluación orientan planes de mejora individuales.', 3 FROM factors WHERE code = 'F05.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.4.C04', id, 'El proceso de evaluación docente es transparente y conocido.', 4 FROM factors WHERE code = 'F05.4';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.5.C01', id, 'Los docentes publican investigaciones en revistas indexadas.', 1 FROM factors WHERE code = 'F05.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.5.C02', id, 'Los docentes participan en proyectos de investigación activos.', 2 FROM factors WHERE code = 'F05.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.5.C03', id, 'La producción académica es reconocida y valorada institucionalmente.', 3 FROM factors WHERE code = 'F05.5';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F05.5.C04', id, 'Existe una política de incentivos a la producción intelectual docente.', 4 FROM factors WHERE code = 'F05.5';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.1.C01', id, 'Existen criterios claros y transparentes de admisión.', 1 FROM factors WHERE code = 'F06.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.1.C02', id, 'El proceso de admisión garantiza igualdad de oportunidades.', 2 FROM factors WHERE code = 'F06.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.1.C03', id, 'Se evalúa el perfil de ingreso de los estudiantes admitidos.', 3 FROM factors WHERE code = 'F06.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.1.C04', id, 'Los resultados del proceso de admisión se comunican oportunamente.', 4 FROM factors WHERE code = 'F06.1';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.2.C01', id, 'Existe un sistema de seguimiento de la permanencia estudiantil.', 1 FROM factors WHERE code = 'F06.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.2.C02', id, 'Se identifican y atienden las causas de deserción estudiantil.', 2 FROM factors WHERE code = 'F06.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.2.C03', id, 'Existen programas de apoyo económico para estudiantes en riesgo.', 3 FROM factors WHERE code = 'F06.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.2.C04', id, 'La tasa de retención estudiantil es monitoreada y mejorada.', 4 FROM factors WHERE code = 'F06.2';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.3.C01', id, 'Existen servicios de tutoría y consejería académica accesibles.', 1 FROM factors WHERE code = 'F06.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.3.C02', id, 'Se ofrecen recursos de apoyo al aprendizaje (biblioteca, laboratorios).', 2 FROM factors WHERE code = 'F06.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.3.C03', id, 'Existen programas de nivelación o refuerzo para estudiantes con dificultades.', 3 FROM factors WHERE code = 'F06.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.3.C04', id, 'Los servicios de apoyo son conocidos y utilizados por los estudiantes.', 4 FROM factors WHERE code = 'F06.3';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.4.C01', id, 'Se promueven actividades extracurriculares, deportivas y culturales.', 1 FROM factors WHERE code = 'F06.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.4.C02', id, 'Existen programas de liderazgo y desarrollo de habilidades blandas.', 2 FROM factors WHERE code = 'F06.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.4.C03', id, 'Se fomenta la participación estudiantil en la vida institucional.', 3 FROM factors WHERE code = 'F06.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F06.4.C04', id, 'Existen mecanismos de atención a la salud mental y bienestar estudiantil.', 4 FROM factors WHERE code = 'F06.4';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.1.C01', id, 'Existe una política formal de investigación institucional.', 1 FROM factors WHERE code = 'F07.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.1.C02', id, 'Se asignan recursos presupuestarios específicos para investigación.', 2 FROM factors WHERE code = 'F07.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.1.C03', id, 'Existe una estructura organizativa que gestiona la investigación.', 3 FROM factors WHERE code = 'F07.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.1.C04', id, 'La política de investigación está alineada con prioridades nacionales y globales.', 4 FROM factors WHERE code = 'F07.1';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.2.C01', id, 'La institución genera publicaciones científicas en revistas indexadas.', 1 FROM factors WHERE code = 'F07.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.2.C02', id, 'Los docentes-investigadores tienen producción científica activa.', 2 FROM factors WHERE code = 'F07.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.2.C03', id, 'Existen grupos o líneas de investigación formalmente constituidos.', 3 FROM factors WHERE code = 'F07.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.2.C04', id, 'La institución participa en redes de investigación nacionales e internacionales.', 4 FROM factors WHERE code = 'F07.2';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.3.C01', id, 'Los estudiantes participan en proyectos de investigación institucional.', 1 FROM factors WHERE code = 'F07.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.3.C02', id, 'Existen semilleros o grupos de investigación estudiantil.', 2 FROM factors WHERE code = 'F07.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.3.C03', id, 'Se reconoce y premia la producción investigativa estudiantil.', 3 FROM factors WHERE code = 'F07.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.3.C04', id, 'Los estudiantes acceden a financiamiento para proyectos de investigación.', 4 FROM factors WHERE code = 'F07.3';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.4.C01', id, 'Las investigaciones institucionales son citadas en literatura especializada.', 1 FROM factors WHERE code = 'F07.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.4.C02', id, 'La institución genera patentes, registros o propiedad intelectual.', 2 FROM factors WHERE code = 'F07.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.4.C03', id, 'Las investigaciones contribuyen a la solución de problemas sociales.', 3 FROM factors WHERE code = 'F07.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.4.C04', id, 'Existe evidencia de impacto de la investigación en políticas públicas.', 4 FROM factors WHERE code = 'F07.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.4.C05', id, 'La institución recibe financiamiento externo competitivo para investigación.', 5 FROM factors WHERE code = 'F07.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F07.4.C06', id, 'Los resultados de investigación se transfieren a la sociedad y la industria.', 6 FROM factors WHERE code = 'F07.4';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.1.C01', id, 'La institución promueve activamente una cultura de innovación.', 1 FROM factors WHERE code = 'F08.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.1.C02', id, 'Existen proyectos de innovación tecnológica en desarrollo.', 2 FROM factors WHERE code = 'F08.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.1.C03', id, 'Se utilizan metodologías de innovación (design thinking, agile, lean, etc.).', 3 FROM factors WHERE code = 'F08.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.1.C04', id, 'Los docentes y estudiantes participan activamente en proyectos de innovación.', 4 FROM factors WHERE code = 'F08.1';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.2.C01', id, 'Existe un programa formal de formación en emprendimiento.', 1 FROM factors WHERE code = 'F08.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.2.C02', id, 'Se apoya la creación de empresas por parte de estudiantes y egresados.', 2 FROM factors WHERE code = 'F08.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.2.C03', id, 'Existen recursos y espacios dedicados al emprendimiento.', 3 FROM factors WHERE code = 'F08.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.2.C04', id, 'Se mide y reporta la tasa de emprendimiento entre estudiantes y egresados.', 4 FROM factors WHERE code = 'F08.2';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.3.C01', id, 'Existen mecanismos formales de transferencia tecnológica al sector productivo.', 1 FROM factors WHERE code = 'F08.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.3.C02', id, 'Se realizan consultorías y asesorías institucionales al sector empresarial.', 2 FROM factors WHERE code = 'F08.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.3.C03', id, 'Se generan convenios de colaboración para transferencia de conocimiento.', 3 FROM factors WHERE code = 'F08.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.3.C04', id, 'Existe evidencia de impacto económico de la transferencia tecnológica.', 4 FROM factors WHERE code = 'F08.3';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.4.C01', id, 'Existe una incubadora de empresas o espacio de coworking institucional.', 1 FROM factors WHERE code = 'F08.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.4.C02', id, 'La incubadora cuenta con mentores y expertos disponibles.', 2 FROM factors WHERE code = 'F08.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.4.C03', id, 'Las empresas incubadas generan empleo y valor económico medible.', 3 FROM factors WHERE code = 'F08.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F08.4.C04', id, 'Existen métricas de seguimiento al desempeño de las empresas incubadas.', 4 FROM factors WHERE code = 'F08.4';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.1.C01', id, 'Existen convenios activos con empresas e instituciones empleadoras.', 1 FROM factors WHERE code = 'F09.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.1.C02', id, 'Los empleadores participan en el diseño y revisión curricular.', 2 FROM factors WHERE code = 'F09.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.1.C03', id, 'Se realizan ferias de empleo y eventos de conexión con empleadores.', 3 FROM factors WHERE code = 'F09.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.1.C04', id, 'Se mide y reporta la satisfacción de los empleadores con los egresados.', 4 FROM factors WHERE code = 'F09.1';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.2.C01', id, 'La institución ofrece programas de educación continua y posgrado.', 1 FROM factors WHERE code = 'F09.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.2.C02', id, 'Los programas de educación continua responden a necesidades del mercado.', 2 FROM factors WHERE code = 'F09.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.2.C03', id, 'Se evalúa la satisfacción de los participantes en educación continua.', 3 FROM factors WHERE code = 'F09.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.2.C04', id, 'La educación continua genera valor y fortalece la reputación institucional.', 4 FROM factors WHERE code = 'F09.2';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.3.C01', id, 'Existe una política formal de responsabilidad social universitaria.', 1 FROM factors WHERE code = 'F09.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.3.C02', id, 'Se realizan proyectos de impacto social con comunidades vulnerables.', 2 FROM factors WHERE code = 'F09.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.3.C03', id, 'Los estudiantes participan en actividades de servicio a la comunidad.', 3 FROM factors WHERE code = 'F09.3';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.3.C04', id, 'Se mide y reporta el impacto social de las actividades institucionales.', 4 FROM factors WHERE code = 'F09.3';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.4.C01', id, 'Se realizan eventos culturales, científicos y académicos abiertos a la comunidad.', 1 FROM factors WHERE code = 'F09.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.4.C02', id, 'La institución difunde conocimiento a través de medios y canales públicos.', 2 FROM factors WHERE code = 'F09.4';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F09.4.C03', id, 'Existen programas de extensión universitaria formalmente establecidos.', 3 FROM factors WHERE code = 'F09.4';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F10.1.C01', id, 'Existe un sistema formal y activo de seguimiento de egresados.', 1 FROM factors WHERE code = 'F10.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F10.1.C02', id, 'Se mide la empleabilidad a 6 meses de graduación.', 2 FROM factors WHERE code = 'F10.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F10.1.C03', id, 'Se mide la empleabilidad a 12 meses de graduación.', 3 FROM factors WHERE code = 'F10.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F10.1.C04', id, 'Se mide la empleabilidad a 24 meses de graduación.', 4 FROM factors WHERE code = 'F10.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F10.1.C05', id, 'Se mide el salario relativo de los egresados frente al mercado.', 5 FROM factors WHERE code = 'F10.1';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F10.2.C01', id, 'Se mide la progresión profesional de los egresados.', 1 FROM factors WHERE code = 'F10.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F10.2.C02', id, 'Se mide la satisfacción de los egresados con su formación recibida.', 2 FROM factors WHERE code = 'F10.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F10.2.C03', id, 'Se mide la satisfacción de los empleadores con el desempeño de los egresados.', 3 FROM factors WHERE code = 'F10.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F10.2.C04', id, 'Se mide la tasa de emprendimiento entre egresados.', 4 FROM factors WHERE code = 'F10.2';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F10.2.C05', id, 'Se mide el impacto social de los egresados en sus comunidades.', 5 FROM factors WHERE code = 'F10.2';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F11.1.C01', id, 'La infraestructura física es adecuada para los procesos académicos.', 1 FROM factors WHERE code = 'F11.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F11.1.C02', id, 'Existen recursos digitales suficientes y actualizados (bases de datos, biblioteca digital).', 2 FROM factors WHERE code = 'F11.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F11.1.C03', id, 'Los recursos de aprendizaje son accesibles para todos los estudiantes.', 3 FROM factors WHERE code = 'F11.1';

INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F12.1.C01', id, 'Existe un sistema institucional de aseguramiento de calidad formalmente establecido.', 1 FROM factors WHERE code = 'F12.1';
INSERT INTO criteria (code, factor_id, name, sort_order) SELECT 'F12.1.C02', id, 'Existe evidencia documentada de mejora continua basada en resultados de evaluación.', 2 FROM factors WHERE code = 'F12.1';

-- ============================================================
-- VERIFY
-- ============================================================
SELECT 'Components' as tabla, COUNT(*) as total FROM components
UNION ALL SELECT 'Factors', COUNT(*) FROM factors
UNION ALL SELECT 'Criteria', COUNT(*) FROM criteria;
