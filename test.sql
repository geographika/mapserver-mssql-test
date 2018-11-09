-- sqlcmd -S localhost\SQLEXPRESS -E -i test.sql

CREATE TABLE Test(
    [fid] [int] NULL,
    [name] [nvarchar](max) NULL,
    [geom] [geometry] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

INSERT INTO Test VALUES(1, 'test',  geometry::STGeomFromText('LINESTRING (0 0, 1 1)', 4326))
GO