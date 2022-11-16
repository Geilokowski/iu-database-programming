-- Fach
CREATE TABLE classes
(
    id         INT IDENTITY,
    class_name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_classes PRIMARY KEY (id),
);

-- Bildungsgang
CREATE TABLE education_courses
(
    id          INT IDENTITY,
    course_name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_education_courses PRIMARY KEY (id),
);

CREATE TABLE teacher
(
    id                 INT IDENTITY,
    surname            VARCHAR(50),
    lastname           VARCHAR(50) NOT NULL,
    primary_class_id   INT         NOT NULL,
    secondary_class_id INT         NOT NULL,
    CONSTRAINT pk_teacher PRIMARY KEY (id),
    CONSTRAINT fk_primary_class
        FOREIGN KEY (primary_class_id) REFERENCES classes (id),
    CONSTRAINT fk_secondary_class
        FOREIGN KEY (secondary_class_id) REFERENCES classes (id),
);

-- Klasse
CREATE TABLE learning_groups
(
    id                  INT IDENTITY,
    group_name          VARCHAR(50) NOT NULL,
    education_course_id INT         NOT NULL,
    teacher_id          INT         NOT NULL,
    CONSTRAINT pk_learning_group PRIMARY KEY (id),
    CONSTRAINT fk_education_course
        FOREIGN KEY (education_course_id) REFERENCES education_courses (id),
    CONSTRAINT fk_teacher
        FOREIGN KEY (teacher_id) REFERENCES teacher (id),
);

CREATE TABLE students
(
    id                     INT IDENTITY,
    firstname              VARCHAR(50),
    lastname               VARCHAR(50) NOT NULL,
    gender                 CHAR(1)     NOT NULL,
    birt_date              DATE        NOT NULL,
    mark_pol               DECIMAL(1, 0), -- This was (1, 1) ?
    mark_german            DECIMAL(1, 0), -- This was (1, 1) ?
    mark_english           DECIMAL(1, 0), -- This was (1, 1) ?
    days_missing           DECIMAL(3, 0) DEFAULT 0,
    days_missing_unexcused DECIMAL(3, 0) DEFAULT 0,
    city                   VARCHAR(50),
    zip_code               CHAR(5),
    street                 VARCHAR(50),
    house_nr               DECIMAL(3, 0),
    learning_group_id      INT,
    CONSTRAINT pk_students PRIMARY KEY (id),
    CONSTRAINT fk_learning_group
        FOREIGN KEY (learning_group_id) REFERENCES learning_groups (id),
);

INSERT INTO classes
VALUES ('Datenbankprogrammierung');
INSERT INTO education_courses
VALUES ('Informatik');
INSERT INTO teacher
VALUES ('Max', 'Musterman', 1, 1)
INSERT INTO learning_groups
VALUES ('INF Studenten', 1, 1)

INSERT INTO students
VALUES (N'Adrian', N'Luebke', 'm', '2002-11-04',
        1, 1, 1, 0, 0,
        N'Berlin', '22334', 'SQL Str.', 6,1);

CREATE FUNCTION dbo.calculate_age(@birth_date DATE)
    RETURNS INT AS
BEGIN
    RETURN DATEDIFF(YY, @birth_date, GETDATE())
END;

-- Test of my new function
SELECT firstname, lastname, dbo.calculate_age(birt_date) age FROM students;

ALTER TABLE students
    ADD CONSTRAINT CHK_student_is_of_eighteen
    CHECK (dbo.calculate_age(birt_date) >= 18);

-- Testing my constraint
INSERT INTO students
VALUES (N'Adrian', N'Luebke', 'm', '2008-11-04',
        1, 1, 1, 0, 0,
        N'Berlin', '22334', 'SQL Str.', 6, 1);
-- INSERT throws error, YEY!