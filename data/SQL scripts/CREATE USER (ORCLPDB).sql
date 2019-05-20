alter session set container = ORCLPDB;  
create user ARM_AKID_J identified by alpha1 default tablespace USERS; 
grant connect, resource to ARM_AKID_J; 
alter user ARM_AKID_J quota unlimited on USERS; 