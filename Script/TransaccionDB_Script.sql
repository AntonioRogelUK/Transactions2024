USE [TransaccionDB]
GO
/****** Object:  Table [dbo].[Folios]    Script Date: 27/01/2024 10:40:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Folios](
	[UltimoFolio] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 27/01/2024 10:40:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ventas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Folio] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Ventas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VentasConceptos]    Script Date: 27/01/2024 10:40:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VentasConceptos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VentaId] [int] NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[PrecioUnitario] [decimal](18, 2) NOT NULL,
	[Cantidad] [decimal](18, 2) NOT NULL,
	[Importe] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_VentasConceptos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Folios] ([UltimoFolio]) VALUES (2)
GO
SET IDENTITY_INSERT [dbo].[Ventas] ON 

INSERT [dbo].[Ventas] ([Id], [Folio], [Fecha], [Total]) VALUES (1, 1, CAST(N'2024-01-27T10:31:07.917' AS DateTime), CAST(52.00 AS Decimal(18, 2)))
INSERT [dbo].[Ventas] ([Id], [Folio], [Fecha], [Total]) VALUES (2, 2, CAST(N'2024-01-27T10:33:02.610' AS DateTime), CAST(52.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Ventas] OFF
GO
SET IDENTITY_INSERT [dbo].[VentasConceptos] ON 

INSERT [dbo].[VentasConceptos] ([Id], [VentaId], [Descripcion], [PrecioUnitario], [Cantidad], [Importe]) VALUES (1, 1, N'Taza', CAST(50.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)))
INSERT [dbo].[VentasConceptos] ([Id], [VentaId], [Descripcion], [PrecioUnitario], [Cantidad], [Importe]) VALUES (2, 1, N'Chicle', CAST(1.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)))
INSERT [dbo].[VentasConceptos] ([Id], [VentaId], [Descripcion], [PrecioUnitario], [Cantidad], [Importe]) VALUES (3, 2, N'Taza', CAST(50.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)))
INSERT [dbo].[VentasConceptos] ([Id], [VentaId], [Descripcion], [PrecioUnitario], [Cantidad], [Importe]) VALUES (4, 2, N'Chicle', CAST(1.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[VentasConceptos] OFF
GO
ALTER TABLE [dbo].[VentasConceptos]  WITH CHECK ADD  CONSTRAINT [FK_VentasConceptos_Ventas] FOREIGN KEY([VentaId])
REFERENCES [dbo].[Ventas] ([Id])
GO
ALTER TABLE [dbo].[VentasConceptos] CHECK CONSTRAINT [FK_VentasConceptos_Ventas]
GO
