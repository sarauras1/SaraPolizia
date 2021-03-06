USE [master]
GO
/****** Object:  Database [SaraPolizia]    Script Date: 14/05/2021 12:07:39 ******/
CREATE DATABASE [SaraPolizia]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SaraPolizia', FILENAME = N'C:\Users\allbe\SaraPolizia.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SaraPolizia_log', FILENAME = N'C:\Users\allbe\SaraPolizia_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [SaraPolizia] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SaraPolizia].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SaraPolizia] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SaraPolizia] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SaraPolizia] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SaraPolizia] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SaraPolizia] SET ARITHABORT OFF 
GO
ALTER DATABASE [SaraPolizia] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SaraPolizia] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SaraPolizia] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SaraPolizia] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SaraPolizia] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SaraPolizia] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SaraPolizia] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SaraPolizia] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SaraPolizia] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SaraPolizia] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SaraPolizia] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SaraPolizia] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SaraPolizia] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SaraPolizia] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SaraPolizia] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SaraPolizia] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SaraPolizia] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SaraPolizia] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SaraPolizia] SET  MULTI_USER 
GO
ALTER DATABASE [SaraPolizia] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SaraPolizia] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SaraPolizia] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SaraPolizia] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SaraPolizia] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SaraPolizia] SET QUERY_STORE = OFF
GO
USE [SaraPolizia]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [SaraPolizia]
GO
/****** Object:  UserDefinedFunction [dbo].[ETA]    Script Date: 14/05/2021 12:07:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[ETA]
(
@dataNascita date
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int
	declare @datan int = year(@dataNascita) * 10000 + month(@dataNascita) * 100 + day(@dataNascita)
	declare @datag int = year(getdate()) *10000 + month(getdate()) * 100 + day(getdate())
	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = (@datag - @dataN) / 10000

	-- Return the result of the function
	RETURN @Result

END
GO
/****** Object:  Table [dbo].[AgentePolizia]    Script Date: 14/05/2021 12:07:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgentePolizia](
	[idAgenti] [int] IDENTITY(1,1) NOT NULL,
	[nome] [nchar](30) NOT NULL,
	[cognome] [nchar](30) NOT NULL,
	[codicefiscale] [nchar](30) NOT NULL,
	[DataNascita] [date] NOT NULL,
	[AnniServizio] [int] NULL,
 CONSTRAINT [PK_AgentePolizia] PRIMARY KEY CLUSTERED 
(
	[idAgenti] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AreaMetropolitana]    Script Date: 14/05/2021 12:07:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AreaMetropolitana](
	[idCodiceArea] [int] IDENTITY(1,1) NOT NULL,
	[codiceArea] [nchar](5) NOT NULL,
	[Rischio] [numeric](1, 0) NOT NULL,
	[idAgenti] [int] NOT NULL,
 CONSTRAINT [PK_AreaMetropolitana] PRIMARY KEY CLUSTERED 
(
	[idCodiceArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_AgentePolizia]    Script Date: 14/05/2021 12:07:40 ******/
CREATE NONCLUSTERED INDEX [IX_AgentePolizia] ON [dbo].[AgentePolizia]
(
	[idAgenti] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AreaMetropolitana]  WITH CHECK ADD  CONSTRAINT [FK_AreaMetropolitana_AgentePolizia] FOREIGN KEY([idAgenti])
REFERENCES [dbo].[AgentePolizia] ([idAgenti])
GO
ALTER TABLE [dbo].[AreaMetropolitana] CHECK CONSTRAINT [FK_AreaMetropolitana_AgentePolizia]
GO
/****** Object:  StoredProcedure [dbo].[InserimentoDatiAgente]    Script Date: 14/05/2021 12:07:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE 

as
BEGIN
   begin try
	declare @idAgente int 
	DELETE FROM AgentePolizia  WHERE @idAgente 
	select idAgenti from AgentePolizia 
	select @idAgente 
	end
END
GO

CREATE PROCEDURE [dbo].[InserimentoDatiAgente] 
	@Nome nvarchar(30),
	@Cognome nvarchar(30),
	@CodiceFiscale nvarchar(50),
	@DataNascita date,
	@AnniServizio int,
	@CodiceArea varchar(5),
    @Rischio numeric(1,0)
AS
BEGIN
	SET NOCOUNT ON;
	begin tran
	begin try
	insert into AgentePolizia (idAgenti, nome, cognome, Codicefiscale, DataNascita, AnniServizio)
	values (@@IDENTITY, @Nome, @Cognome, @CodiceFiscale, @DataNascita, @AnniServizio)
	
	
	insert into AreaMetropolitana (Rischio, codiceArea)
	values (@Rischio, @CodiceArea)
	
   commit 
   end try
   begin catch
    
   IF(dbo.ETA(@DataNascita) > 17)
  begin
 select @DataNascita 
  end
   ELSE begin
   select ERROR_MESSAGE()  
  end

   ROLLBACK
   END CATCH 
   RETURN @@ROWCOUNT
	
	
 END
GO
/****** Object:  StoredProcedure [dbo].[visualizzaDatiElenco]    Script Date: 14/05/2021 12:07:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--visualizza i dati dell elenco aree a rischio che hanno meno di 3 anni di servizio
CREATE PROCEDURE [dbo].[visualizzaDatiElenco]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select min(3)AnniServizio, Rischio = 0 from  [dbo].[AgentePolizia] c inner join [dbo].[AreaMetropolitana] b
	on c.idAgenti = b.idAgenti
	order by [AnniServizio], [Rischio]
    -- Insert statements for procedure here

END
GO
/****** Object:  StoredProcedure [dbo].[visualizzaNumeroAgenti]    Script Date: 14/05/2021 12:07:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--visualizza il numeero agenti assegnati per ongni area
CREATE PROCEDURE [dbo].[visualizzaNumeroAgenti]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select Count(c.idAgenti), Count(b.codiceArea), Count(b.Rischio) from [dbo].[AgentePolizia] c inner join [dbo].[AreaMetropolitana] b
	on c.idAgenti = b.idAgenti
	group by c.idAgenti, b.codiceArea, b.Rischio
    -- Insert statements for procedure here

END
GO
USE [master]
GO
ALTER DATABASE [SaraPolizia] SET  READ_WRITE 
GO
