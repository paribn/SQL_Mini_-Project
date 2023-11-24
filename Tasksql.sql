use Library

create table Authors(
ID int identity (1,1)primary key,
Name varchar (255) not  null,
Surname varchar (255) not null
)

create table Books (
ID int identity (100,1)primary key,
Name VARCHAR(100) CHECK (LEN(Name) BETWEEN 2 AND 100) NOT NULL,
PageCount int check (PageCount>=10) not null,
)


create table AuthorsBooks(
ID int identity (200,1) primary key,
AuthorsID int foreign key references Authors(ID) not null,
BookID int foreign key references Books(ID) not null
)

insert into Authors 
values
('Stephen','King'),
('Peter','Straub'),
('James','Patterson'),
('Andrew','Gross'),
('Neil','Gaiman'),
('Frank','Herbert'),
('Isaac','Asimov'),
('Kurban','Said')

insert into Books
values
('Dune',896),
('The Talisman',784),
('American Gods',560),
('The Shining',688),
('Foundation',896),
('ALi and Nino',240),
('Paper Towns',336),
('The Fault in Our Stars',313)

select *from Books
select *from Authors
select *from AuthorsBooks

--drop table Authors
--drop table Books
--drop table AuthorsBooks
--TRUNCATE table AuthorsBooks

insert into AuthorsBooks (AuthorsID,BookID)
values 
(6,100),
(1,101),
(2,101),
(5,102),
(1,103),
(7,104),
(8,105)


go
CREATE VIEW concatenated_view AS
select ab.ID,
b.Name as 'Books Name', CONCAT(a.Name, ' ', a.surname) AS AuthorFullName,
b.PageCount from AuthorsBooks ab
join Books b on ab.BookID= b.ID
join Authors a on ab.AuthorsID= a.ID


select*from concatenated_view




CREATE PROCEDURE GetBooksByAuthorName(@authorName VARCHAR(255))
as
begin
    SELECT Books.ID, Books.Name, Books.PageCount, CONCAT(Authors.Name, ' ', Authors.Surname) AS AuthorFullName
    FROM Authors
    JOIN AuthorsBooks ON Authors.ID = AuthorsBooks.AuthorsID
    JOIN Books ON AuthorsBooks.BookID = Books.ID
    WHERE CONCAT(Authors.Name, ' ', Authors.Surname) = @authorName;
	end;

	--- insert

create proc InsertAuthor
@Name varchar(50),
@Surname varchar(50)
as
begin
    insert into Authors 
	values ( @Name, @Surname);
end;


---- update

CREATE PROCEDURE UpdateAuthor
    @Id INT,
    @Name VARCHAR(50),
    @Surname VARCHAR(50)
as
begin
    UPDATE Authors
    SET Name = @Name,
        Surname = @Surname
    WHERE Id = @Id;
end;

--delete

create proc DeleteAuthors
    @AuthorsId INT
as
begin
    delete from Authors
    where Id = @AuthorsId;
end;


---

CREATE VIEW AuthorsInfo
AS select Authors.ID ,
         concat(Authors.Name, ' ',Authors.Surname)  AS AuthorFullName,
		 count(AuthorsBooks.BookID) as BooksCount,
         MAX(Books.PageCount) as MaxPageCount
from Authors
 join AuthorsBooks on  Authors.ID = AuthorsBooks.AuthorsID	
 join Books ON AuthorsBooks.BookID = Books.ID
group by
    Authors.ID, concat(Authors.Name, ' ',Authors.Surname) 


select*from AuthorsInfo










 