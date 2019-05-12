CREATE DATABASE ARM
COLLATE Cyrillic_General_CI_AS
GO


USE [ARM]
GO


CREATE TABLE [workers]
(
	[id_person] int PRIMARY KEY NOT NULL IDENTITY(1,1),	
	[w_name] nvarchar(20) NULL,
	[w_surname] nvarchar(20) NULL,
	[w_patronymic] nvarchar(20) NULL,
	[sex] nvarchar(10) NULL,
	[birth_date] date NULL,
	[dose_before_npp] date NULL,
	[dose_chnpp] date NULL,
	[iku_year] int NULL,
	[iku_month] int NULL,
	[weight] int NULL,
	[height] int NULL,
	[date_on] date NULL,
	[date_of] date NULL,
	[emergency_dose] bit NULL,
	[disable_radiation] bit NULL,
    
	[Doznarad_position] int NULL
)
GO



    // добавить внешние ключи на другие таблицы
ALTER TABLE [workers]
ADD	
	[department] int FOREIGN KEY REFERENCES [adm_department](ID),
	[assignement] int FOREIGN KEY REFERENCES [adm_assignement](ID),
	[room_name] int FOREIGN KEY REFERENCES [adm_room](ID),
	[person_type] int FOREIGN KEY REFERENCES [adm_person_type](ID),
	[dose_status] int FOREIGN KEY REFERENCES [adm_dose_status](ID)
go





CREATE TABLE [tek_person]
(
	/*[id_person] int PRIMARY KEY NOT NULL IDENTITY(1,1),*/
	[id] int PRIMARY KEY NOT NULL IDENTITY(1,1),
	[id_person] int FOREIGN KEY REFERENCES [tek_postanovka](id_person),
	[passport_series] int NULL,
	[passport_number] int NULL,	
	[passport_vydan] nvarchar(20) NULL,
	[passport_date] date NULL,
	[polis_number] nvarchar(20) NULL,
	[polis_series] nvarchar(20) NULL,
	[pension_number] nvarchar(20) NULL,
	[home_tel] nvarchar(20) NULL,
	[home_address] nvarchar(20) NULL,
	[work_tel] nvarchar(20) NULL,
	[work_address] nvarchar(20) NULL,
)
GO



CREATE TABLE [adm_assignement]
(
	[ID] int PRIMARY KEY NOT NULL IDENTITY(1,1),
	[assignement] nvarchar(20) NULL
)
GO

CREATE TABLE [adm_category]
(
	[ID] int PRIMARY KEY NOT NULL IDENTITY(1,1),
	[category] nvarchar(20) NULL
)
GO

CREATE TABLE [adm_department]
(
	[ID] int PRIMARY KEY NOT NULL IDENTITY(1,1),
	[department] nvarchar(20) NULL
)
GO

CREATE TABLE [adm_ose_status]
(
	[ID] int PRIMARY KEY NOT NULL IDENTITY(1,1),
	[ose_status] nvarchar(20) NULL
)
GO


CREATE TABLE [adm_room]
(
	[ID] int PRIMARY KEY NOT NULL IDENTITY(1,1),
	[room] nvarchar(20) NULL,
	[id_zone] int NULL	
)
GO

CREATE TABLE [adm_state]
(
	[ID] int PRIMARY KEY NOT NULL IDENTITY(1,1),
	[state_name] nvarchar(20) NULL,
	[state_color] nvarchar(20) NULL	
)
GO

CREATE TABLE [adm_status_1_dos]
(
	[ID] int PRIMARY KEY NOT NULL IDENTITY(1,1),
	[status_1_dos] nvarchar(20) NULL
)
GO

CREATE TABLE [adm_person_type]
(
	[ID] int PRIMARY KEY NOT NULL IDENTITY(1,1),
	[person_type] nvarchar(20) NULL
)
GO

CREATE TABLE [adm_dose_status]
(
	[ID] int PRIMARY KEY NOT NULL IDENTITY(1,1),
	[dose_status] nvarchar(20) NULL
)
GO











USE [DB_DEMO]
GO

INSERT INTO [User] ([Login], [Password], [e_mail], [VIP]) VALUES 
	('Kate',   '12345',  'kate@mail.ru',1),
	('Leonid', 'qwerty',   'leon@mail.ru',1),
	('Lena',   'q1w2e3r4',  'lena@mail.ru',0),
	('Anton',  '54321',  'anton@mail.ru',0)
GO


INSERT INTO [Order] ([Description], [ID_user]) VALUES 
	('туфли 1_1', 1),
	('туфли 2_1', 1),
	('туфли 3_1', 1),
	('туфли 4_1', 1),
	('туфли 5_1', 1),
	('информация о заказе 6_2', 2),
	('информация о заказе 7_3', 3),
	('информация о заказе 8_3', 3),
	('информация о заказе 9_3', 3),
	('информация о заказе 10_4', 4),
	('информация о заказе 11_4', 4)
GO

