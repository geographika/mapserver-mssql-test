MSSQLDriver Test Case
=====================

See https://github.com/mapserver/mapserver/issues/5702

To recreate:

#. Download http://download.gisinternals.com/sdk/downloads/release-1911-x64-gdal-2-3-2-mapserver-7-2-1.zip (although issue occurs when 
   compiling locally)
#. Download SQL Server 2017 Express edition - https://www.microsoft.com/en-us/sql-server/sql-server-editions-express (error also occurring on standard SQL Server 2016 database v13.0.5081.1)
#. Run the following command to create a new Test table with one record in the master database:

   ``sqlcmd -S localhost\SQLEXPRESS -E -i test.sql``
   
#. Update the test.map path to the mssql2008 plugin:

   ``PLUGIN "D:\MapServer\release-1911-x64-gdal-2-3-2-mapserver-7-2-1\bin\ms\plugins\mssql2008\msplugin_mssql2008.dll"``
   
#. Run ``SDKShell.bat`` in the release download to setup the environment. 
#. cd to the Mapfile location and run:

   ``mapserv -nh "QUERY_STRING=map=test.map&SERVICE=WFS&VERSION=1.1.0&REQUEST=GetFeature&TYPENAME=test&MAXFEATURES=1" > output.xml``
   
#. output.xml shows the expected output, output2.xml shows the issue - ``<ms:fid></ms:fid>`` is empty. 

Debugging Notes
---------------

On line 1767 changing to ``char dummyBuffer[16];`` prevents an error at line 1813 ``rc = SQLGetData(layerinfo->conn->hstmt, (SQLUSMALLINT)(t + 1), SQL_C_BINARY, dummyBuffer, 0, &needLen);``
However integer values are not returned. 