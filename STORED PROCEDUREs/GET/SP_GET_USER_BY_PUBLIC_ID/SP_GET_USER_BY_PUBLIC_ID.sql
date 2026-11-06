ALTER PROCEDURE SP_GET_USER_BY_PUBLIC_ID
@Public_ID CHAR(10)
AS
BEGIN 


    BEGIN TRY 

    
            IF NOT EXISTS (SELECT 1 FROM Users WHERE [Public_ID] =  @Public_ID)
            THROW 50004, 'User Not Found', 4;
            
            SELECT 
                Public_ID,
                FullName,
                Gender,
                DateOfBirth,
                UserName,
                Avatar,
                Bio,
                Email
                FROM 
                Users u INNER JOIN Persons p ON
                u.Person_ID = p.Person_ID WHERE u.[Public_ID] = @Public_ID;


    END TRY 

    BEGIN CATCH 
        THROW;
    END CATCH


END
 
 




