This project uses Code First entity framework.

DOCUMENTATION NOT COMPLETE

Dev process involving Schema changes:
1 - make change(s) to model
2 - in Package Manager Console run:
	Add-Migration MIGRATIONNAME		(this creates the migration file)
	Update-Database -Script			(this creates a script file that can be used to update other databases, must be done first)
	Update-Database					(this updates your local database based on your connection string)


Deploy process:
