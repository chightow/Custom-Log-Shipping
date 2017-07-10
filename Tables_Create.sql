USE [CLS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[RestoreDatabaseList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Servername] [varchar](1000) NULL,
	[Databasename] [varchar](1000) NULL,
	[Directory] [varchar](1000) NULL,
	[LastRestoredBackupSetGuid] [uniqueidentifier] NULL,
	[Restore] [bit] NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[FolderFiles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Directory] [varchar](1000) NULL,
	[File] [varchar](1000) NULL,
	[InsertedOn] [datetime] NULL DEFAULT (getutcdate()),
	[DeletedOn] [datetime] NULL,
	[Deleted] [bit] NULL DEFAULT ((0)),
	[FileHash] [varchar](64) NULL,
	[RestoreDatabaseListID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[FolderFiles]  WITH CHECK ADD FOREIGN KEY([RestoreDatabaseListID])
REFERENCES [dbo].[RestoreDatabaseList] ([ID])
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Headers](
	[FolderFilesID] [int] NULL,
	[BackupName] [nvarchar](128) NULL,
	[BackupDescription] [nvarchar](255) NULL,
	[BackupType] [smallint] NULL,
	[ExpirationDate] [datetime] NULL,
	[Compressed] [tinyint] NULL,
	[Position] [smallint] NULL,
	[DeviceType] [tinyint] NULL,
	[UserName] [nvarchar](128) NULL,
	[ServerName] [nvarchar](128) NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[DatabaseVersion] [bigint] NULL,
	[DatabaseCreationDate] [datetime] NULL,
	[BackupSize] [numeric](20, 0) NULL,
	[FirstLSN] [numeric](25, 0) NULL,
	[LastLSN] [numeric](25, 0) NULL,
	[CheckpointLSN] [numeric](25, 0) NULL,
	[DatabaseBackupLSN] [numeric](25, 0) NULL,
	[BackupStartDate] [datetime] NULL,
	[BackupFinishDate] [datetime] NULL,
	[SortOrder] [smallint] NULL,
	[CodePage] [smallint] NULL,
	[UnicodeLocaleId] [bigint] NULL,
	[UnicodeComparisonStyle] [bigint] NULL,
	[CompatibilityLevel] [tinyint] NULL,
	[SoftwareVendorId] [bigint] NULL,
	[SoftwareVersionMajor] [bigint] NULL,
	[SoftwareVersionMinor] [bigint] NULL,
	[SoftwareVersionBuild] [bigint] NULL,
	[MachineName] [nvarchar](128) NULL,
	[Flags] [bigint] NULL,
	[BindingID] [uniqueidentifier] NULL,
	[RecoveryForkID] [uniqueidentifier] NULL,
	[Collation] [nvarchar](128) NULL,
	[FamilyGUID] [uniqueidentifier] NULL,
	[HasBulkLoggedData] [bigint] NULL,
	[IsSnapshot] [bigint] NULL,
	[IsReadOnly] [bigint] NULL,
	[IsSingleUser] [bigint] NULL,
	[HasBackupChecksums] [bigint] NULL,
	[IsDamaged] [bigint] NULL,
	[BegibsLogChain] [bigint] NULL,
	[HasIncompleteMetaData] [bigint] NULL,
	[IsForceOffline] [bigint] NULL,
	[IsCopyOnly] [bigint] NULL,
	[FirstRecoveryForkID] [uniqueidentifier] NULL,
	[ForkPointLSN] [numeric](25, 0) NULL,
	[RecoveryModel] [nvarchar](128) NULL,
	[DifferentialBaseLSN] [numeric](25, 0) NULL,
	[DifferentialBaseGUID] [uniqueidentifier] NULL,
	[BackupTypeDescription] [nvarchar](128) NULL,
	[BackupSetGUID] [uniqueidentifier] NULL,
	[CompressedBackupSize] [bigint] NULL,
	[Containment] [bigint] NULL,
	[KeyAlgorithm] [nvarchar](32) NULL,
	[EncryptorThumbprint] [varbinary](20) NULL,
	[EncryptorType] [nvarchar](23) NULL,
	[Restored] [bit] NULL DEFAULT ((0)),
	[RestoredDate] [datetime] NULL DEFAULT (NULL)
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Headers]  WITH CHECK ADD FOREIGN KEY([FolderFilesID])
REFERENCES [dbo].[FolderFiles] ([ID])
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Labels](
	[FolderFilesID] [int] NULL,
	[MediaName] [varchar](255) NULL,
	[MediaSetId] [uniqueidentifier] NULL,
	[FamilyCount] [int] NULL,
	[FamilySequenceNumber] [int] NULL,
	[MediaFamilyId] [uniqueidentifier] NULL,
	[MediaSequenceNumber] [int] NULL,
	[MediaLabelPresent] [bit] NULL,
	[MediaDescription] [varchar](255) NULL,
	[SoftwareName] [varchar](255) NULL,
	[SoftwareVendorId] [int] NULL,
	[MediaDate] [datetime] NULL,
	[MirrorCount] [int] NULL,
	[IsCompressed] [bit] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Labels]  WITH CHECK ADD FOREIGN KEY([FolderFilesID])
REFERENCES [dbo].[FolderFiles] ([ID])
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[RestoreServers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RestoreDatabaseListID] [int] NULL,
	[Restore_Servername] [varchar](1000) NULL,
	[Restore_Databasename] [varchar](1000) NULL,
	[NewRoot] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[RestoreServers]  WITH CHECK ADD FOREIGN KEY([RestoreDatabaseListID])
REFERENCES [dbo].[RestoreDatabaseList] ([ID])
GO





