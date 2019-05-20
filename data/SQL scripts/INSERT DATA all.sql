
--------------------------------------------------------
--  ADM_ASSIGNEMENT
--------------------------------------------------------

INSERT INTO ADM_ASSIGNEMENT (ASSIGNEMENT, ASSIGNEMENT_CODE) VALUES ('Инженер',     '22446');
INSERT INTO ADM_ASSIGNEMENT (ASSIGNEMENT, ASSIGNEMENT_CODE) VALUES ('Программист', '25857');
INSERT INTO ADM_ASSIGNEMENT (ASSIGNEMENT, ASSIGNEMENT_CODE) VALUES ('Дозиметрист', '11856');
INSERT INTO ADM_ASSIGNEMENT (ASSIGNEMENT, ASSIGNEMENT_CODE) VALUES ('Дозорный на стене', '21204');




--------------------------------------------------------
--  ADM_DEPARTMENT_NPP
--------------------------------------------------------

INSERT INTO ADM_DEPARTMENT_NPP (DEPARTMENT_NPP) VALUES ('Department A');
INSERT INTO ADM_DEPARTMENT_NPP (DEPARTMENT_NPP) VALUES ('Department B');
INSERT INTO ADM_DEPARTMENT_NPP (DEPARTMENT_NPP) VALUES ('Department C');
INSERT INTO ADM_DEPARTMENT_NPP (DEPARTMENT_NPP) VALUES ('Department D');


--------------------------------------------------------
--  ADM_ORGANIZATION
--------------------------------------------------------

INSERT INTO ADM_ORGANIZATION (ORGANIZATION_, DEPARTMENT) VALUES ('Organization 1','Department 1_A');
INSERT INTO ADM_ORGANIZATION (ORGANIZATION_, DEPARTMENT) VALUES ('Organization 1','Department 1_B');
INSERT INTO ADM_ORGANIZATION (ORGANIZATION_, DEPARTMENT) VALUES ('Organization 2','Department 2_A');
INSERT INTO ADM_ORGANIZATION (ORGANIZATION_, DEPARTMENT) VALUES ('Organization 2','Department 2_B');
INSERT INTO ADM_ORGANIZATION (ORGANIZATION_, DEPARTMENT) VALUES ('Organization 2','Department 2_C');
INSERT INTO ADM_ORGANIZATION (ORGANIZATION_, DEPARTMENT) VALUES ('Organization 3','Department 3_AB');


--------------------------------------------------------
--  ADM_STATUS
--------------------------------------------------------

INSERT INTO ADM_STATUS (STATUS_CODE, STATUS) VALUES (1, 'Работал весь отчетный год');
INSERT INTO ADM_STATUS (STATUS_CODE, STATUS) VALUES (2, 'Прикомандирован в отчетном году');
INSERT INTO ADM_STATUS (STATUS_CODE, STATUS) VALUES (3, 'Уволился в отчетном году');
INSERT INTO ADM_STATUS (STATUS_CODE, STATUS) VALUES (4, 'Вышел на пенсию в отчетном году');
INSERT INTO ADM_STATUS (STATUS_CODE, STATUS) VALUES (5, 'Умер в отчетном году');


commit;