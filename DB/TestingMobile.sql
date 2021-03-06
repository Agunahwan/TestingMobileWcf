USE [master]
GO
/****** Object:  Database [TestingMobile]    Script Date: 24/02/2016 22:32:26 ******/
CREATE DATABASE [TestingMobile]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestingMobile', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TestingMobile.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TestingMobile_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TestingMobile_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TestingMobile] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestingMobile].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestingMobile] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestingMobile] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestingMobile] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestingMobile] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestingMobile] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestingMobile] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestingMobile] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [TestingMobile] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestingMobile] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestingMobile] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestingMobile] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestingMobile] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestingMobile] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestingMobile] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestingMobile] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestingMobile] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestingMobile] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestingMobile] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestingMobile] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestingMobile] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestingMobile] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestingMobile] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestingMobile] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestingMobile] SET RECOVERY FULL 
GO
ALTER DATABASE [TestingMobile] SET  MULTI_USER 
GO
ALTER DATABASE [TestingMobile] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestingMobile] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestingMobile] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestingMobile] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TestingMobile', N'ON'
GO
USE [TestingMobile]
GO
/****** Object:  User [produk]    Script Date: 24/02/2016 22:32:26 ******/
CREATE USER [produk] FOR LOGIN [produk] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 24/02/2016 22:32:26 ******/
CREATE USER [NT AUTHORITY\SYSTEM] FOR LOGIN [NT AUTHORITY\SYSTEM] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCountSoal]    Script Date: 24/02/2016 22:32:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCountSoal] @IdTipeSoal INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT count(1) AS JumlahSoal
	FROM tblSoal
	WHERE id_tipe_soal = @IdTipeSoal
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetLogin]    Script Date: 24/02/2016 22:32:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetLogin] @Username VARCHAR(50)
	,@Password VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT *
	FROM tblUser
	WHERE username = @Username
		AND password = @Password
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetNilai]    Script Date: 24/02/2016 22:32:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetNilai] @IdUser INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT nilai
	FROM tblUser
	WHERE id_user = @IdUser
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetSoal]    Script Date: 24/02/2016 22:32:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetSoal] @IdTipeSoal INT
	,@Urutan INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	WITH Records
	AS (
		SELECT row_number() OVER (
				ORDER BY id_soal
				) AS 'row'
			,*
		FROM tblSoal
		WHERE id_tipe_soal = @IdTipeSoal
		)
	SELECT *
	FROM records
	WHERE row = @Urutan
END


GO
/****** Object:  StoredProcedure [dbo].[sp_InsertJawaban]    Script Date: 24/02/2016 22:32:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertJawaban] @IdUser INT
	,@IdSoal INT
	,@Jawaban VARCHAR(1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	INSERT INTO tblJawaban (
		id_soal
		,id_user
		,jawaban
		)
	VALUES (
		@IdSoal
		,@IdUser
		,@Jawaban
		)

	SELECT '1' AS Result;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateNilai]    Script Date: 24/02/2016 22:32:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateNilai] @IdUser INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Nilai INT

	-- Insert statements for procedure here
	SELECT @Nilai = count(1)
	FROM tblJawaban jwb
	INNER JOIN tblSoal soal ON jwb.id_soal = soal.id_soal
		AND jwb.jawaban = soal.jawaban_benar
	WHERE jwb.id_user = @IdUser

	UPDATE tblUser
	SET nilai = @Nilai
	WHERE id_user = @IdUser

	SELECT 1 AS 'Result'
END

GO
/****** Object:  Table [dbo].[tblJawaban]    Script Date: 24/02/2016 22:32:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblJawaban](
	[id_jawaban] [int] IDENTITY(1,1) NOT NULL,
	[id_soal] [int] NULL,
	[id_user] [int] NULL,
	[jawaban] [varchar](1) NULL,
 CONSTRAINT [PK_tblJawaban] PRIMARY KEY CLUSTERED 
(
	[id_jawaban] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblSoal]    Script Date: 24/02/2016 22:32:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblSoal](
	[id_soal] [int] IDENTITY(1,1) NOT NULL,
	[id_tipe_soal] [int] NULL,
	[soal] [varchar](max) NULL,
	[jawaban_a] [varchar](50) NULL,
	[jawaban_b] [varchar](50) NULL,
	[jawaban_c] [varchar](50) NULL,
	[jawaban_d] [varchar](50) NULL,
	[jawaban_benar] [varchar](1) NULL,
 CONSTRAINT [PK_tblSoal] PRIMARY KEY CLUSTERED 
(
	[id_soal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTipeSoal]    Script Date: 24/02/2016 22:32:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTipeSoal](
	[id_tipe_soal] [int] IDENTITY(1,1) NOT NULL,
	[tipe_soal] [varchar](50) NULL,
 CONSTRAINT [PK_tblTipeSoal] PRIMARY KEY CLUSTERED 
(
	[id_tipe_soal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 24/02/2016 22:32:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUser](
	[id_user] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[nilai] [decimal](10, 2) NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [TestingMobile] SET  READ_WRITE 
GO
