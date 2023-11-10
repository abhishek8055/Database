-- TRANSACTION
/*
	Transaction create a staging area for changes

	BEGIN TRANSACTION
		SQL COMMAND 1 (say Insert)
		SQL COMMAND 2 (say Create)
		SQL COMMAND 2 (say Delete)
		.
		.
		.
		SQL COMMAND N (say Update)
	COMMIT - To Confirm
	ROLLBACK - To Undo

	**if you BEGIN transaction, system will wait fot the for COMMIT or ROLLBACK command 
	till then whatever operation you perform will be temparory 
	and will be final only after COMMIT or ROLLBACK command
*/

USE SchoolManagement_DB;

BEGIN TRANSACTION
	Delete from Lecturers Where Id = 19
Rollback
--COMMIT

Delete from Lecturers Where Id = 20