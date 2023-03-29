This file was made for a class in database engineering, and was built to run on the Oracle Database Manager system. It was NOT designed with normalization in mind,
and as such is highly susceptible to injection and update anomaly. This database was created to demonstrate the basic functions of the Oracle environment, including
features such as views, indices, simple queries, and CRUD rules. Note that the data containe din this database as example data is also completely fictional.

This repository also contains an ERD to track the relationship between tables (not counting tables created at runtime,) and a small algorithm txt file that details key
relationships for attributes in each table.

To create this database so it can be viewed, simply run any of the given script files in a PL/SQL environment, starting with "CFTableCreate.sql" to actually make the
table. This database is related to a webpage I created previously for a Jquery class, which can be found (for context) at http://cs.iupui.edu/~dkruze/n341/Final/catalog/catalog.html
