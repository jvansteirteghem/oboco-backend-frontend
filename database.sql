use oboco;

create table bookCollectionMarks (id bigint not null auto_increment, createDate timestamp(3) not null default current_timestamp(3), updateDate timestamp(3) not null default current_timestamp(3), userId bigint not null, bookCollectionId bigint not null, numberOfBookPages integer not null, bookPage integer not null, primary key (id));
create table bookCollections (id bigint not null auto_increment, directoryPath varchar(4096) not null, name varchar(255) not null, normalizedName varchar(255) not null, createDate timestamp(3) not null default current_timestamp(3), updateDate timestamp(3) not null default current_timestamp(3), rootBookCollectionId bigint, parentBookCollectionId bigint, numberOfBookCollections integer not null, numberOfBooks integer not null, numberOfBookPages integer not null, number integer not null, primary key (id));
create table bookMarkReferences (id bigint not null auto_increment, bookId bigint not null, bookMarkId bigint not null, primary key (id));
create table bookMarks (id bigint not null auto_increment, fileId varchar(64) not null, numberOfPages integer not null, page integer not null, createDate timestamp(3) not null default current_timestamp(3), updateDate timestamp(3) not null default current_timestamp(3), userId bigint not null, primary key (id));
create table books (id bigint not null auto_increment, fileId varchar(64) not null, filePath varchar(4096) not null, name varchar(255) not null, normalizedName varchar(255) not null, numberOfPages integer not null, createDate timestamp(3) not null default current_timestamp(3), updateDate timestamp(3) not null default current_timestamp(3), bookCollectionId bigint not null, rootBookCollectionId bigint not null, number integer not null, primary key (id));
create table userRoles (userId bigint not null, role varchar(255) not null);
create table users (id bigint not null auto_increment, name varchar(255) not null, passwordHash varchar(60) not null, createDate timestamp(3) not null default current_timestamp(3), updateDate timestamp(3) not null default current_timestamp(3), rootBookCollectionId bigint, primary key (id));

alter table bookCollectionMarks add constraint FKacm12b7i2glkb9bscnsqvd4rb unique (userId, bookCollectionId);
alter table bookCollectionMarks add constraint FKecm1297i2glkb9bssnsqvd4rb foreign key (userId) references users(id);
alter table bookCollectionMarks add constraint FKecm9391i4glkb7bssnsqvd5rb foreign key (bookCollectionId) references bookCollections(id) on delete cascade;
create index bookCollectionMarkCreateDate on bookCollectionMarks (createDate);
create index bookCollectionMarkUpdateDate on bookCollectionMarks (updateDate);

alter table bookCollections add constraint FKiufb5ykonq8jxly61he6muql0 foreign key (rootBookCollectionId) references bookCollections(id) on delete cascade;
alter table bookCollections add constraint FKiufb3ykonq6jxly95he6muql0 foreign key (parentBookCollectionId) references bookCollections(id) on delete cascade;
create index bookCollectionDirectoryPath on bookCollections (directoryPath);
create index bookCollectionNormalizedName on bookCollections (normalizedName);
create index bookCollectionNumber on bookCollections (number);
create index bookCollectionCreateDate on bookCollections (createDate);
create index bookCollectionUpdateDate on bookCollections (updateDate);

alter table bookMarks add constraint FKefm1898i2glgb1dddnshvd3rb unique (userId, fileId);
alter table bookMarks add constraint FKecm1898i2glkb1dddnsqvd3rb foreign key (userId) references users(id);
create index bookMarkFileId on bookMarks (fileId);
create index bookMarkCreateDate on bookMarks (createDate);
create index bookMarkUpdateDate on bookMarks (updateDate);

alter table bookMarkReferences add constraint FKecmi391i4glkbjdddnsqkd5rb unique (bookId, bookMarkId);
alter table bookMarkReferences add constraint FKecm9391i4glkb7dddnsqvd5rb foreign key (bookId) references books(id) on delete cascade;
alter table bookMarkReferences add constraint FKl2ijhkebftw3gdgmlkseo49kp foreign key (bookMarkId) references bookMarks(id) on delete cascade;

alter table books add constraint FKe6gb0v6dtxns6rgtd8bv4ri0h foreign key (bookCollectionId) references bookCollections(id);
alter table books add constraint FKe2gb0v6dtxns3rgtd1bv2ri0h foreign key (rootBookCollectionId) references bookCollections(id);
create index bookNormalizedName on books (normalizedName);
create index bookFileId on books (fileId);
create index bookFilePath on books (filePath);
create index bookNumber on books (number);
create index bookCreateDate on books (createDate);
create index bookUpdateDate on books (updateDate);

alter table userRoles add constraint FKgqpfwr3766gtqga2i0kgmlwlu foreign key (userId) references users(id);

alter table users add constraint FKe9xa0v3dtxasmrgtd7bn5rixh unique (name);
alter table users add constraint FKe9gb0v3dtxns6rgtd7bv5ri1h foreign key (rootBookCollectionId) references bookCollections(id) on delete set null;
create index userCreateDate on users (createDate);
create index userUpdateDate on users (updateDate);

insert into users (id, name, passwordHash, createDate, updateDate) values (1, 'administrator', '$2a$12$msu32WtSMaQVCJsIDKCxkOTVOGRrncBjUe5x63GbY/RizCJ/zyFPC', current_timestamp, current_timestamp);
insert into userRoles (userId, role) values (1, 'ADMINISTRATOR');
insert into userRoles (userId, role) values (1, 'USER');
