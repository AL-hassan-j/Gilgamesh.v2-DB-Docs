CREATE TABLE [dbo].[Users] (
    [User_ID]         INT            IDENTITY (1, 1) NOT NULL,
    [Person_ID]       INT            NOT NULL,
    [UserName]        NVARCHAR (100) NOT NULL,
    [Avatar]          NVARCHAR (300) NULL,
    [Bio]             NVARCHAR (250) NULL,
    [Email]           NVARCHAR (100) NOT NULL,
    [PasswordHash]    VARCHAR (256)  NOT NULL,
    [UserRule]        NVARCHAR (30)  CONSTRAINT [DF_User_Rule] DEFAULT ('user') NOT NULL,
    [EmailVerifiedAt] DATETIME2 (7)  NULL,
    [isDeleted]       BIT            CONSTRAINT [DEFAULT_Users_isDeleted] DEFAULT ((0)) NULL,
    [DeletedAt]       DATETIME       NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([User_ID] ASC),
    CONSTRAINT [FK_User_Person] FOREIGN KEY ([Person_ID]) REFERENCES [dbo].[Persons] ([Person_ID]),
    CONSTRAINT [UQ_User_Person_ID] UNIQUE NONCLUSTERED ([Person_ID] ASC),
    CONSTRAINT [UQ_Users_Email] UNIQUE NONCLUSTERED ([Email] ASC),
    CONSTRAINT [UQ_Users_UserName] UNIQUE NONCLUSTERED ([UserName] ASC)
);

