IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Speakers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Speakers](
	[speakerID] [int] IDENTITY(1,1) NOT NULL,
	[speakerUid] [uniqueidentifier] NOT NULL DEFAULT(newid()),
	[speakerTypeID] [int] NULL,
	[firstName] [nvarchar](150) NULL,
	[lastName] [nvarchar](150) NULL,
	[jobTitle] [nvarchar](150) NULL,
	[company] [nvarchar](150) NULL,
	[email] [varchar](150) NULL,
	[bio] [nvarchar](max) NULL,
	[hideSpeaker] [bit] NOT NULL,
	[createdOn] [datetime] NOT NULL,
	[updatedOn] [datetime] NOT NULL,
	[isActive] [bit] NOT NULL DEFAULT(1),
 CONSTRAINT [PK__Speakers__59D7F6CD15CD901A] PRIMARY KEY CLUSTERED
(
	[speakerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SpeakerTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SpeakerTypes](
	[speakerTypeID] [int] IDENTITY(1,1) NOT NULL,
	[speakerTypeUid] [uniqueidentifier] NOT NULL DEFAULT(newid()),
	[speakerTypeName] [nvarchar](150) NOT NULL,
	[sortOrder] [int] NULL,
	[createdOn] [datetime] NOT NULL,
	[updatedOn] [datetime] NOT NULL,
	[isActive] [bit] NOT NULL DEFAULT(1),
 CONSTRAINT [PK__SpeakerT__C5C3774570094436] PRIMARY KEY CLUSTERED
(
	[speakerTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET IDENTITY_INSERT [dbo].[SpeakerTypes] ON;

INSERT INTO [dbo].[SpeakerTypes]([speakerTypeID], [speakerTypeUid], [speakerTypeName], [sortOrder], [createdOn], [updatedOn], [isActive])
SELECT 1, N'979fa36b-2898-4b3b-94a7-031f629a7c9d', N'Keynote', 0, getdate(), getdate(), 1

SET IDENTITY_INSERT [dbo].[SpeakerTypes] OFF;

IF OBJECT_ID('[dbo].[mpsp_SpeakersRead]') IS NOT NULL
BEGIN
    DROP PROC [dbo].[mpsp_SpeakersRead]
END
GO
CREATE PROC [dbo].[mpsp_SpeakersRead]
    @speakerID int
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON

	BEGIN TRAN

	SELECT [speakerID], [speakerUid], [speakerTypeID], [firstName], [lastName], [jobTitle], [company], [email], [bio], [hideSpeaker], [createdOn], [updatedOn], [isActive]
	FROM   [dbo].[Speakers] WITH (NOLOCK)
	WHERE  ([speakerID] = @speakerID OR @speakerID IS NULL)

	COMMIT
GO
IF OBJECT_ID('[dbo].[mpsp_SpeakersCreate]') IS NOT NULL
BEGIN
    DROP PROC [dbo].[mpsp_SpeakersCreate]
END
GO
CREATE PROC [dbo].[mpsp_SpeakersCreate]
    @speakerUid uniqueidentifier,
    @speakerTypeID int = NULL,
    @firstName nvarchar(150) = NULL,
    @lastName nvarchar(150) = NULL,
    @jobTitle nvarchar(150) = NULL,
    @company nvarchar(150) = NULL,
    @email varchar(150) = NULL,
    @bio nvarchar(MAX) = NULL,
    @hideSpeaker bit,
    @createdOn datetime,
    @updatedOn datetime,
    @isActive bit
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON

	BEGIN TRAN

	INSERT INTO [dbo].[Speakers] ([speakerUid], [speakerTypeID], [firstName], [lastName], [jobTitle], [company], [email], [bio], [hideSpeaker], [createdOn], [updatedOn], [isActive])
	SELECT @speakerUid, @speakerTypeID, @firstName, @lastName, @jobTitle, @company, @email, @bio, @hideSpeaker, @createdOn, @updatedOn, @isActive

	-- Begin Return Select <- do not remove
	SELECT [speakerID], [speakerUid], [speakerTypeID], [firstName], [lastName], [jobTitle], [company], [email], [bio], [hideSpeaker], [createdOn], [updatedOn], [isActive]
	FROM   [dbo].[Speakers] WITH (NOLOCK)
	WHERE  [speakerID] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove

	COMMIT
GO
IF OBJECT_ID('[dbo].[mpsp_SpeakersUpdate]') IS NOT NULL
BEGIN
    DROP PROC [dbo].[mpsp_SpeakersUpdate]
END
GO
CREATE PROC [dbo].[mpsp_SpeakersUpdate]
    @speakerID int,
    @speakerUid uniqueidentifier,
    @speakerTypeID int = NULL,
    @firstName nvarchar(150) = NULL,
    @lastName nvarchar(150) = NULL,
    @jobTitle nvarchar(150) = NULL,
    @company nvarchar(150) = NULL,
    @email varchar(150) = NULL,
    @bio nvarchar(MAX) = NULL,
    @hideSpeaker bit,
    @createdOn datetime,
    @updatedOn datetime,
    @isActive bit
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON

	BEGIN TRAN

	UPDATE [dbo].[Speakers]
	SET    [speakerUid] = @speakerUid, [speakerTypeID] = @speakerTypeID, [firstName] = @firstName, [lastName] = @lastName, [jobTitle] = @jobTitle, [company] = @company, [email] = @email, [bio] = @bio, [hideSpeaker] = @hideSpeaker, [createdOn] = @createdOn, [updatedOn] = @updatedOn, [isActive] = @isActive
	WHERE  [speakerID] = @speakerID

	-- Begin Return Select <- do not remove
	SELECT [speakerID], [speakerUid], [speakerTypeID], [firstName], [lastName], [jobTitle], [company], [email], [bio], [hideSpeaker], [createdOn], [updatedOn], [isActive]
	FROM   [dbo].[Speakers] WITH (NOLOCK)
	WHERE  [speakerID] = @speakerID
	-- End Return Select <- do not remove

	COMMIT
GO
IF OBJECT_ID('[dbo].[mpsp_SpeakersDelete]') IS NOT NULL
BEGIN
    DROP PROC [dbo].[mpsp_SpeakersDelete]
END
GO
CREATE PROC [dbo].[mpsp_SpeakersDelete]
    @speakerID int
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON

	BEGIN TRAN

	DELETE
	FROM   [dbo].[Speakers]
	WHERE  [speakerID] = @speakerID

	COMMIT
GO

IF OBJECT_ID('[dbo].[mpsp_SpeakerTypesRead]') IS NOT NULL
BEGIN
    DROP PROC [dbo].[mpsp_SpeakerTypesRead]
END
GO
CREATE PROC [dbo].[mpsp_SpeakerTypesRead]
    @speakerTypeID int
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON

	BEGIN TRAN

	SELECT [speakerTypeID], [speakerTypeUid], [speakerTypeName], [sortOrder], [createdOn], [updatedOn], [isActive]
	FROM   [dbo].[SpeakerTypes] WITH (NOLOCK)
	WHERE  ([speakerTypeID] = @speakerTypeID OR @speakerTypeID IS NULL)

	COMMIT
GO
IF OBJECT_ID('[dbo].[mpsp_SpeakerTypesCreate]') IS NOT NULL
BEGIN
    DROP PROC [dbo].[mpsp_SpeakerTypesCreate]
END
GO
CREATE PROC [dbo].[mpsp_SpeakerTypesCreate]
    @speakerTypeUid uniqueidentifier,
    @speakerTypeName nvarchar(150),
    @sortOrder int = NULL,
    @createdOn datetime,
    @updatedOn datetime,
    @isActive bit
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON

	BEGIN TRAN

	INSERT INTO [dbo].[SpeakerTypes] ([speakerTypeUid], [speakerTypeName], [sortOrder], [createdOn], [updatedOn], [isActive])
	SELECT @speakerTypeUid, @speakerTypeName, @sortOrder, @createdOn, @updatedOn, @isActive

	-- Begin Return Select <- do not remove
	SELECT [speakerTypeID], [speakerTypeUid], [speakerTypeName], [sortOrder], [createdOn], [updatedOn], [isActive]
	FROM   [dbo].[SpeakerTypes] WITH (NOLOCK)
	WHERE  [speakerTypeID] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove

	COMMIT
GO
IF OBJECT_ID('[dbo].[mpsp_SpeakerTypesUpdate]') IS NOT NULL
BEGIN
    DROP PROC [dbo].[mpsp_SpeakerTypesUpdate]
END
GO
CREATE PROC [dbo].[mpsp_SpeakerTypesUpdate]
    @speakerTypeID int,
    @speakerTypeUid uniqueidentifier,
    @speakerTypeName nvarchar(150),
    @sortOrder int = NULL,
    @createdOn datetime,
    @updatedOn datetime,
    @isActive bit
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON

	BEGIN TRAN

	UPDATE [dbo].[SpeakerTypes]
	SET    [speakerTypeUid] = @speakerTypeUid, [speakerTypeName] = @speakerTypeName, [sortOrder] = @sortOrder, [createdOn] = @createdOn, [updatedOn] = @updatedOn, [isActive] = @isActive
	WHERE  [speakerTypeID] = @speakerTypeID

	-- Begin Return Select <- do not remove
	SELECT [speakerTypeID], [speakerTypeUid], [speakerTypeName], [sortOrder], [createdOn], [updatedOn], [isActive]
	FROM   [dbo].[SpeakerTypes] WITH (NOLOCK)
	WHERE  [speakerTypeID] = @speakerTypeID
	-- End Return Select <- do not remove

	COMMIT
GO
IF OBJECT_ID('[dbo].[mpsp_SpeakerTypesDelete]') IS NOT NULL
BEGIN
    DROP PROC [dbo].[mpsp_SpeakerTypesDelete]
END
GO
CREATE PROC [dbo].[mpsp_SpeakerTypesDelete]
    @speakerTypeID int
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON

	BEGIN TRAN

	DELETE
	FROM   [dbo].[SpeakerTypes]
	WHERE  [speakerTypeID] = @speakerTypeID

	COMMIT
GO