CREATE TABLE [dbo].[Persons] (
    [Person_ID]        INT           IDENTITY (1, 1) NOT NULL,
    [Public_ID]        CHAR (10)     NOT NULL,
    [FullName]         NVARCHAR (50) NOT NULL,
    [Gender]           VARCHAR (10)  CONSTRAINT [DF_Persons_Gender] DEFAULT ('male') NOT NULL,
    [DateOfBirth]      DATE          NOT NULL,
    [UserRestrictions] BIGINT        CONSTRAINT [DF_Persons_Restrictions] DEFAULT ((0)) NOT NULL,
    [CreatedAt]        DATETIME2 (7) CONSTRAINT [DF_Persons_CreatedAt] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Persons] PRIMARY KEY CLUSTERED ([Person_ID] ASC),
    CONSTRAINT [CK_Persons_Gender] CHECK ([Gender]='other' OR [Gender]='female' OR [Gender]='male'),
    CONSTRAINT [UQ_Persons_PublicID] UNIQUE NONCLUSTERED ([Public_ID] ASC)
);
