USE [master]
GO
/****** Object:  Database [APIN09601]    Script Date: 14/02/2023 02:39:06 م ******/
CREATE DATABASE [APIN09601]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'APIN09601', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER2019\MSSQL\DATA\APIN09601.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'APIN09601_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER2019\MSSQL\DATA\APIN09601_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [APIN09601].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [APIN09601] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [APIN09601] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [APIN09601] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [APIN09601] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [APIN09601] SET ARITHABORT OFF 
GO
ALTER DATABASE [APIN09601] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [APIN09601] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [APIN09601] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [APIN09601] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [APIN09601] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [APIN09601] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [APIN09601] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [APIN09601] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [APIN09601] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [APIN09601] SET  DISABLE_BROKER 
GO
ALTER DATABASE [APIN09601] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [APIN09601] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [APIN09601] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [APIN09601] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [APIN09601] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [APIN09601] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [APIN09601] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [APIN09601] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [APIN09601] SET  MULTI_USER 
GO
ALTER DATABASE [APIN09601] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [APIN09601] SET DB_CHAINING OFF 
GO
ALTER DATABASE [APIN09601] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [APIN09601] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [APIN09601] SET DELAYED_DURABILITY = DISABLED 
GO
USE [APIN09601]
GO
/****** Object:  Table [dbo].[TblAssessment Type]    Script Date: 14/02/2023 02:39:06 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAssessment Type](
	[assesId] [int] IDENTITY(1,1) NOT NULL,
	[assesEducational] [int] NULL,
	[assesSpecialist] [int] NULL,
 CONSTRAINT [PK_TblAssessment Type] PRIMARY KEY CLUSTERED 
(
	[assesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tblcommissioning Type]    Script Date: 14/02/2023 02:39:06 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tblcommissioning Type](
	[comId] [int] IDENTITY(1,1) NOT NULL,
	[comOrigienality] [nvarchar](50) NULL,
	[comCommissioning] [nvarchar](50) NULL,
	[comPurchase Parking Pass] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tblcommissioning Type] PRIMARY KEY CLUSTERED 
(
	[comId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCommittees]    Script Date: 14/02/2023 02:39:06 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCommittees](
	[comId] [int] IDENTITY(1,1) NOT NULL,
	[comNameOrgans] [int] NULL,
	[comTimLimit] [date] NULL,
	[comNoCommittees] [int] NULL,
	[comDateCommittees] [date] NULL,
	[comCommitteesRecomandations] [nvarchar](max) NULL,
	[comNote] [nvarchar](max) NULL,
	[comManagersInfo] [int] NULL,
	[comDirectorateAssessment] [int] NULL,
	[comAssessmentType] [int] NULL,
	[comStructural] [int] NULL,
 CONSTRAINT [PK_tblCommittees] PRIMARY KEY CLUSTERED 
(
	[comId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEducational]    Script Date: 14/02/2023 02:39:06 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEducational](
	[eduInt] [int] IDENTITY(1,1) NOT NULL,
	[eduBelowMiddle] [nvarchar](50) NULL,
	[eduMiddle] [nvarchar](50) NULL,
	[eduAboveMiddle] [nvarchar](50) NULL,
	[eduGood] [nvarchar](50) NULL,
 CONSTRAINT [PK_TblEducational] PRIMARY KEY CLUSTERED 
(
	[eduInt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblManagers Info]    Script Date: 14/02/2023 02:39:06 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblManagers Info](
	[infoId] [int] IDENTITY(1,1) NOT NULL,
	[infRank] [int] NULL,
	[infoFullName] [nvarchar](100) NULL,
	[infoStaticalNumber] [nvarchar](100) NULL,
	[infoPosition] [int] NULL,
	[infoCommissiongType] [int] NULL,
 CONSTRAINT [PK_tblManagers Info] PRIMARY KEY CLUSTERED 
(
	[infoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblNameOrgans]    Script Date: 14/02/2023 02:39:06 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNameOrgans](
	[orgId] [int] IDENTITY(1,1) NOT NULL,
	[orgRank] [int] NULL,
	[orgName] [nvarchar](100) NULL,
 CONSTRAINT [PK_tblNameOrgans] PRIMARY KEY CLUSTERED 
(
	[orgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPosition]    Script Date: 14/02/2023 02:39:06 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPosition](
	[posInt] [int] IDENTITY(1,1) NOT NULL,
	[posDep] [nvarchar](50) NULL,
	[posOrg] [nvarchar](50) NULL,
	[posDirectorGeneral] [nvarchar](50) NULL,
 CONSTRAINT [PK_TblPosition] PRIMARY KEY CLUSTERED 
(
	[posInt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRank]    Script Date: 14/02/2023 02:39:06 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRank](
	[rnkId] [int] IDENTITY(1,1) NOT NULL,
	[rnkRank] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblRank] PRIMARY KEY CLUSTERED 
(
	[rnkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblSpecialist]    Script Date: 14/02/2023 02:39:06 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblSpecialist](
	[speId] [int] IDENTITY(1,1) NOT NULL,
	[speFit] [nvarchar](50) NULL,
	[speNotFit] [nvarchar](50) NULL,
 CONSTRAINT [PK_TblSpecialist] PRIMARY KEY CLUSTERED 
(
	[speId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblStructural]    Script Date: 14/02/2023 02:39:06 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblStructural](
	[strId] [int] IDENTITY(1,1) NOT NULL,
	[strAgency] [nvarchar](100) NULL,
	[strDirectorateGeneral] [nvarchar](100) NULL,
	[strSubDirctorate] [nvarchar](100) NULL,
 CONSTRAINT [PK_TblStructural] PRIMARY KEY CLUSTERED 
(
	[strId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TblAssessment Type]  WITH CHECK ADD  CONSTRAINT [FK_TblAssessment Type_TblEducational] FOREIGN KEY([assesEducational])
REFERENCES [dbo].[TblEducational] ([eduInt])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TblAssessment Type] CHECK CONSTRAINT [FK_TblAssessment Type_TblEducational]
GO
ALTER TABLE [dbo].[TblAssessment Type]  WITH CHECK ADD  CONSTRAINT [FK_TblAssessment Type_TblSpecialist] FOREIGN KEY([assesSpecialist])
REFERENCES [dbo].[TblSpecialist] ([speId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TblAssessment Type] CHECK CONSTRAINT [FK_TblAssessment Type_TblSpecialist]
GO
ALTER TABLE [dbo].[tblCommittees]  WITH CHECK ADD  CONSTRAINT [FK_tblCommittees_TblAssessment Type] FOREIGN KEY([comAssessmentType])
REFERENCES [dbo].[TblAssessment Type] ([assesId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblCommittees] CHECK CONSTRAINT [FK_tblCommittees_TblAssessment Type]
GO
ALTER TABLE [dbo].[tblCommittees]  WITH CHECK ADD  CONSTRAINT [FK_tblCommittees_TblAssessment Type1] FOREIGN KEY([comAssessmentType])
REFERENCES [dbo].[TblAssessment Type] ([assesId])
GO
ALTER TABLE [dbo].[tblCommittees] CHECK CONSTRAINT [FK_tblCommittees_TblAssessment Type1]
GO
ALTER TABLE [dbo].[tblCommittees]  WITH CHECK ADD  CONSTRAINT [FK_tblCommittees_tblManagers Info] FOREIGN KEY([comManagersInfo])
REFERENCES [dbo].[tblManagers Info] ([infoId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblCommittees] CHECK CONSTRAINT [FK_tblCommittees_tblManagers Info]
GO
ALTER TABLE [dbo].[tblCommittees]  WITH CHECK ADD  CONSTRAINT [FK_tblCommittees_tblNameOrgans] FOREIGN KEY([comNameOrgans])
REFERENCES [dbo].[tblNameOrgans] ([orgId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblCommittees] CHECK CONSTRAINT [FK_tblCommittees_tblNameOrgans]
GO
ALTER TABLE [dbo].[tblCommittees]  WITH CHECK ADD  CONSTRAINT [FK_tblCommittees_TblStructural] FOREIGN KEY([comStructural])
REFERENCES [dbo].[TblStructural] ([strId])
GO
ALTER TABLE [dbo].[tblCommittees] CHECK CONSTRAINT [FK_tblCommittees_TblStructural]
GO
ALTER TABLE [dbo].[tblManagers Info]  WITH CHECK ADD  CONSTRAINT [FK_tblManagers Info_Tblcommissioning Type] FOREIGN KEY([infoCommissiongType])
REFERENCES [dbo].[Tblcommissioning Type] ([comId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblManagers Info] CHECK CONSTRAINT [FK_tblManagers Info_Tblcommissioning Type]
GO
ALTER TABLE [dbo].[tblManagers Info]  WITH CHECK ADD  CONSTRAINT [FK_tblManagers Info_TblPosition] FOREIGN KEY([infoPosition])
REFERENCES [dbo].[TblPosition] ([posInt])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblManagers Info] CHECK CONSTRAINT [FK_tblManagers Info_TblPosition]
GO
ALTER TABLE [dbo].[tblManagers Info]  WITH CHECK ADD  CONSTRAINT [FK_tblManagers Info_tblRank] FOREIGN KEY([infRank])
REFERENCES [dbo].[tblRank] ([rnkId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblManagers Info] CHECK CONSTRAINT [FK_tblManagers Info_tblRank]
GO
ALTER TABLE [dbo].[tblNameOrgans]  WITH CHECK ADD  CONSTRAINT [FK_tblNameOrgans_tblRank] FOREIGN KEY([orgRank])
REFERENCES [dbo].[tblRank] ([rnkId])
GO
ALTER TABLE [dbo].[tblNameOrgans] CHECK CONSTRAINT [FK_tblNameOrgans_tblRank]
GO
USE [master]
GO
ALTER DATABASE [APIN09601] SET  READ_WRITE 
GO
