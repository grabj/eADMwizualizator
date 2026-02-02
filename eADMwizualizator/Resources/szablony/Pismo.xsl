<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:adr="http://crd.gov.pl/xml/schematy/adres/2009/11/09/" 
    xmlns:oso="http://crd.gov.pl/xml/schematy/osoba/2009/11/16/" 
    xmlns:inst="http://crd.gov.pl/xml/schematy/instytucja/2009/11/16/" 
    xmlns:meta="http://crd.gov.pl/xml/schematy/meta/2009/11/16/" 
    xmlns:str="http://crd.gov.pl/xml/schematy/struktura/2009/11/16/" 
    xmlns:wnio="http://crd.gov.pl/wzor/2013/12/12/1410/" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:ds="http://www.w3.org/2000/09/xmldsig#" 
    xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:ns2="http://crd.gov.pl/xml/schematy/meta/2009/11/16/"
    xmlns:ns3="http://crd.gov.pl/xml/schematy/instytucja/2009/11/16/"
    xmlns:ns4="http://crd.gov.pl/xml/schematy/adres/2009/11/09/"
    xmlns:ns6="http://crd.gov.pl/wzor/2013/12/12/1410/"
    version="1.0" 
    xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform http://www.w3.org/2005/02/schema-for-xslt20.xsd" 
    exclude-result-prefixes="adr oso inst meta wnio ds str xsi ns2 ns3 ns4 ns6">
	
	<xsl:output method="xml" encoding="utf-8" indent="yes" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="ns6:Dokument | wnio:Dokument"/>
	</xsl:template>
	
	<xsl:template match="ns6:Dokument | wnio:Dokument">
		<xsl:param name="tresc" select="ns6:TrescDokumentu | wnio:TrescDokumentu"/>
		<html>
			<head>
				<title>Dokument elektroniczny</title>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<style type="text/css">
          .body
          {
          text-align: justify;
          font-size: 11px;
          font-family: Verdana;
          line-height: 20px;
          }
		  .mainTxt 
		  {
		    text-align: justify;
			font-size: 12px;
			font-family: Verdana;
			line-height: 20px;
			white-space: pre-wrap;
			word-wrap: break-word;
		  }	  
		  .mainTxtContainer 
		  {
			
		  }
		  
		  .acc {
			position: absolute;
			left: -9999px;
		  }
		  
		  .osw {
			list-style-type: none;
			padding: 0px;
		  }
		  
		  .oswli{
			
		  }
        </style>
			</head>
			<body class="body">
				<div style="width: 100%;">
					<xsl:call-template name="NaglowekStandard"/>
					<xsl:if test="string-length(ns6:DaneDokumentu/str:Naglowek/str:NazwaDokumentu | wnio:DaneDokumentu/str:Naglowek/str:NazwaDokumentu) &gt; 0">
						<p align="center" style="text-align: center;font-size: 12px;font-family: Verdana;line-height: 20px;padding-top: 10px;">
							<span style="font-weight: bold;font-size: 12px;">
								<xsl:value-of select="ns6:DaneDokumentu/str:Naglowek/str:NazwaDokumentu | wnio:DaneDokumentu/str:Naglowek/str:NazwaDokumentu"/>
							</span>
						</p>
					</xsl:if>
					<br/>
					<xsl:call-template name="RodzajDokumentu"/>
					<xsl:call-template name="TytulDokumentu"/>
					<h4 class="acc">Treść dokumentu</h4>
					<xsl:for-each select="$tresc/ns6:Informacje/ns6:Informacja | $tresc/wnio:Informacje/wnio:Informacja">
						<xsl:if test="string-length(.) &gt; 0">
							<div class="mainTxtContainer">
								<pre class="mainTxt">
									<xsl:value-of select="."/>
								</pre>
							</div>
						</xsl:if>
					</xsl:for-each>
					<xsl:call-template name="Oswiadczenia"/>
					<xsl:call-template name="InformacjeDodatkowe">
						<xsl:with-param name="informacje" select="$tresc/ns6:InformacjeDodatkowe | $tresc/wnio:InformacjeDodatkowe"/>
					</xsl:call-template>
					<xsl:call-template name="Upowaznienie"/>
					<xsl:call-template name="Zalaczniki"/>
					<xsl:call-template name="DoWiadomosci"/>
					<xsl:call-template name="Podpis"/>
				</div>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="NaglowekStandard">
		<h1 class="acc">Dokument elektroniczny</h1>
		<h2 class="acc">Dane nadawców</h2>
		<p style="width: 340px;text-align: left;font-size: 12px;font-family: Verdana;line-height: 20px;float:left;">
			<xsl:call-template name="Podmioty">
				<xsl:with-param name="podmiot" select="ns6:DaneDokumentu/Nadawcy | wnio:DaneDokumentu/str:Nadawcy"/>
			</xsl:call-template>
		</p>
		<h2 class="acc">Miejsce i data sporządzenia dokumentu</h2>
		<p style="text-align: right;font-size: 12px;font-family: Verdana;line-height: 20px;float: right">
			<xsl:call-template name="MiejscowoscData"/>
		</p>
		<div style="clear: both;"/>
		<h2 class="acc">Dane adresatów</h2>
		<div align="right" style="text-align: right;font-size: 12px;font-family: Verdana;line-height: 20px;">
			<table style="float: right;">
				<tr>
					<td style="width: auto;max-width: 300px;">
						<p align="left" style="text-align: left;font-size: 12px;font-family: Verdana;line-height: 20px;max-width: 280px">
							<xsl:call-template name="Podmioty">
								<xsl:with-param name="podmiot" select="ns6:DaneDokumentu/Adresaci | wnio:DaneDokumentu/str:Adresaci"/>
							</xsl:call-template>
						</p>
					</td>
				</tr>
			</table>
		</div>
		<xsl:if test="string-length(ns6:DaneDokumentu/str:Naglowek/meta:Identyfikator/meta:Wartosc | wnio:DaneDokumentu/str:Naglowek/meta:Identyfikator/meta:Wartosc) &gt; 0">
			<p align="left" style="text-align: left;font-size: 12px;font-family: Verdana;line-height: 20px;">
				<xsl:value-of select="ns6:DaneDokumentu/str:Naglowek/meta:Identyfikator/meta:Wartosc | wnio:DaneDokumentu/str:Naglowek/meta:Identyfikator/meta:Wartosc"/>
			</p>
		</xsl:if>
		<div style="clear: both;"/>
	</xsl:template>
	
	<xsl:template name="Zalaczniki">
		<xsl:param name="zalaczniki" select="ns6:TrescDokumentu/Zalaczniki | wnio:TrescDokumentu/str:Zalaczniki"/>
		<xsl:if test="count($zalaczniki/Zalacznik | $zalaczniki/str:Zalacznik) &gt; 0">
			<div style="text-align: left;">
				<h2 style="font-size: 11px;font-family: Verdana;line-height: 20px;padding: 0px;margin:0px; font-weight: normal;">Załączniki:</h2>
				<ol style="padding-top: 0px;margin-top: 0px;">
					<xsl:for-each select="$zalaczniki/Zalacznik[@nazwaPliku != ''] | $zalaczniki/str:Zalacznik[@nazwaPliku != '']">
						<li>
							<xsl:if test="@kodowanie='base64'">
								<xsl:value-of select="@nazwaPliku"/>
								<xsl:if test="string-length(str:OpisZalacznika | OpisZalacznika) &gt; 0"> - </xsl:if>
								<xsl:if test="string-length(str:OpisZalacznika | OpisZalacznika) &gt; 0">
									<xsl:value-of select="str:OpisZalacznika | OpisZalacznika"/>
								</xsl:if>
							</xsl:if>
							<xsl:if test="@kodowanie='URI'">
								<a href="{DaneZalacznika | str:DaneZalacznika}">
									<xsl:value-of select="@nazwaPliku"/>
								</a>
								<xsl:if test="string-length(OpisZalacznika | str:OpisZalacznika) &gt; 0">
				 (wartość skrótu w chwili załączania: 
				  <xsl:value-of select="OpisZalacznika | str:OpisZalacznika"/>)
				</xsl:if>
							</xsl:if>
						</li>
					</xsl:for-each>
				</ol>
			</div>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="MiejscowoscData">
		<xsl:param name="miejscowosc" select="ns6:TrescDokumentu/ns6:MiejscowoscDokumentu | wnio:TrescDokumentu/wnio:MiejscowoscDokumentu"/>
		<xsl:param name="data" select="ns6:DaneDokumentu/ns2:Data[@typDaty='stworzony']/ns2:Czas | wnio:DaneDokumentu/meta:Data[@typDaty='stworzony']/meta:Czas"/>
		<xsl:value-of select="$miejscowosc"/>,
		<xsl:value-of select="' '"/>
		<xsl:call-template name="FormatujDate">
		<xsl:with-param name="data" select="$data"/>
	</xsl:call-template>
	</xsl:template>

	<xsl:template name="FormatujDate">
		<xsl:param name="data"/>
		<xsl:variable name="rok" select="substring($data, 1, 4)"/>
		<xsl:variable name="miesiac" select="substring($data, 6, 2)"/>
		<xsl:variable name="dzien" select="substring($data, 9, 2)"/>
		<xsl:variable name="godzina" select="substring($data, 12, 2)"/>
		<xsl:variable name="minuta" select="substring($data, 15, 2)"/>
		
		<xsl:variable name="nazwaMiesiaca">
			<xsl:choose>
				<xsl:when test="$miesiac='01'">stycznia</xsl:when>
				<xsl:when test="$miesiac='02'">lutego</xsl:when>
				<xsl:when test="$miesiac='03'">marca</xsl:when>
				<xsl:when test="$miesiac='04'">kwietnia</xsl:when>
				<xsl:when test="$miesiac='05'">maja</xsl:when>
				<xsl:when test="$miesiac='06'">czerwca</xsl:when>
				<xsl:when test="$miesiac='07'">lipca</xsl:when>
				<xsl:when test="$miesiac='08'">sierpnia</xsl:when>
				<xsl:when test="$miesiac='09'">września</xsl:when>
				<xsl:when test="$miesiac='10'">października</xsl:when>
				<xsl:when test="$miesiac='11'">listopada</xsl:when>
				<xsl:when test="$miesiac='12'">grudnia</xsl:when>
				<xsl:otherwise><xsl:value-of select="$miesiac"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:choose>
			<!-- Jeśli data zawiera godzinę -->
			<xsl:when test="string-length($godzina) &gt; 0">
				<xsl:value-of select="concat($dzien, ' ', $nazwaMiesiaca, ' ', $rok, ' r., godz. ', $godzina, ':', $minuta)"/>
			</xsl:when>
			<!-- Tylko data bez godziny -->
			<xsl:otherwise>
				<xsl:value-of select="concat($dzien, ' ', $nazwaMiesiaca, ' ', $rok, ' r.')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="PodmiotKontakt">
		<xsl:param name="kontakt" select="ns4:Kontakt | adr:Kontakt"/>
		<xsl:param name="inline" select="'false'"/>
		<xsl:for-each select="$kontakt/ns4:Telefon | $kontakt/adr:Telefon">
			<xsl:if test="string-length(.) &gt; 0">
				<xsl:value-of select="concat('Telefon: ',.)"/>
				<xsl:call-template name="InLine">
					<xsl:with-param name="value" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="$kontakt/ns4:Faks | $kontakt/adr:Faks">
			<xsl:if test="string-length(.) &gt; 0">
				<xsl:value-of select="concat('Faks: ',.)"/>
				<xsl:call-template name="InLine">
					<xsl:with-param name="value" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="$kontakt/ns4:Email | $kontakt/adr:Email">
			<xsl:if test="string-length(.) &gt; 0">
				<xsl:value-of select="concat('Email: ',.)"/>
				<xsl:call-template name="InLine">
					<xsl:with-param name="value" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="$kontakt/ns4:URIKontakt | $kontakt/adr:URIKontakt">
			<xsl:if test="string-length(.) &gt; 0">
				<xsl:value-of select="concat('',.)"/>
				<xsl:call-template name="InLine">
					<xsl:with-param name="value" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="$kontakt/ns4:InnyKontakt | $kontakt/adr:InnyKontakt">
			<xsl:if test="string-length(.) &gt; 0">
				<xsl:value-of select="concat('',.)"/>
				<xsl:call-template name="InLine">
					<xsl:with-param name="value" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="PodmiotIdentyfikatory">
		<xsl:param name="id" select="oso:IdOsoby"/>
		<xsl:param name="inline" select="'false'"/>
		<xsl:if test="string-length($id/oso:PESEL) &gt; 0">
			<xsl:value-of select="concat('PESEL: ',$id/oso:PESEL)"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="string-length($id/oso:NIP) &gt; 0">
			<xsl:value-of select="concat('NIP: ',$id/oso:NIP)"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="string-length($id/oso:InnyIdentyfikator/oso:WartoscIdentyfikatora) &gt; 0">
			<xsl:if test="string-length($id/oso:InnyIdentyfikator/oso:TypIdentyfikatora) &gt; 0">
				<xsl:value-of select="$id/oso:InnyIdentyfikator/oso:TypIdentyfikatora"/>
				<xsl:value-of select="': '"/>
			</xsl:if>
			<xsl:value-of select="$id/oso:InnyIdentyfikator/oso:WartoscIdentyfikatora"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="string-length($id/ns3:KRS | $id/inst:KRS) &gt; 0">
			<xsl:value-of select="concat('KRS: ',$id/ns3:KRS | $id/inst:KRS)"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="string-length($id/ns3:NIP | $id/inst:NIP) &gt; 0">
			<xsl:value-of select="concat('NIP: ',$id/ns3:NIP | $id/inst:NIP)"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="string-length($id/ns3:REGON | $id/inst:REGON) &gt; 0">
			<xsl:value-of select="concat('REGON: ',$id/ns3:REGON | $id/inst:REGON)"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="string-length($id/ns3:InnyIdentyfikator/ns3:WartoscIdentyfikatora | $id/inst:InnyIdentyfikator/inst:WartoscIdentyfikatora) &gt; 0">
			<xsl:if test="string-length($id/ns3:InnyIdentyfikator/ns3:TypIdentyfikatora | $id/inst:InnyIdentyfikator/inst:TypIdentyfikatora) &gt; 0">
				<xsl:value-of select="$id/ns3:InnyIdentyfikator/ns3:TypIdentyfikatora | $id/inst:InnyIdentyfikator/inst:TypIdentyfikatora"/>
				<xsl:value-of select="': '"/>
			</xsl:if>
			<xsl:value-of select="$id/ns3:InnyIdentyfikator/ns3:WartoscIdentyfikatora | $id/inst:InnyIdentyfikator/inst:WartoscIdentyfikatora"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="PodmiotOsoba">
		<xsl:param name="osoba" select="wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/oso:Osoba"/>
		<xsl:param name="inline" select="'false'"/>
		<xsl:value-of select="$osoba/oso:Imie"/>
		<xsl:if test="string-length($osoba/oso:ImieDrugie) &gt; 0">
			<xsl:value-of select="' '"/>
			<xsl:value-of select="$osoba/oso:ImieDrugie"/>
		</xsl:if>
		<xsl:for-each select="$osoba/oso:Nazwisko[string-length(.) &gt; 0]">
			<xsl:value-of select="' '"/>
			<xsl:value-of select="."/>
		</xsl:for-each>
		<xsl:call-template name="InLine">
			<xsl:with-param name="value" select="$inline"/>
		</xsl:call-template>
		<xsl:if test="count($osoba/ns4:Adres | $osoba/adr:Adres) &gt; 0">
			<xsl:call-template name="Adres">
				<xsl:with-param name="adres" select="$osoba/ns4:Adres | $osoba/adr:Adres"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="count($osoba/oso:IdOsoby) &gt; 0">
			<xsl:call-template name="PodmiotIdentyfikatory">
				<xsl:with-param name="id" select="$osoba/oso:IdOsoby"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="count($osoba/ns4:Kontakt | $osoba/adr:Kontakt) &gt; 0">
			<xsl:call-template name="PodmiotKontakt">
				<xsl:with-param name="kontakt" select="$osoba/ns4:Kontakt | $osoba/adr:Kontakt"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="PodmiotInstytucja">
		<xsl:param name="instytucja" select="wnio:DaneDokumentu/str:Adresaci/meta:Podmiot/inst:Instytucja"/>
		<xsl:param name="inline" select="'false'"/>
		<xsl:if test="string-length($instytucja/ns3:NazwaInstytucji | $instytucja/inst:NazwaInstytucji) &gt; 0">
			<xsl:value-of select="$instytucja/ns3:NazwaInstytucji | $instytucja/inst:NazwaInstytucji"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$instytucja/ns3:Jednostka | $instytucja/inst:Jednostka">
			<xsl:call-template name="PodmiotJednostka">
				<xsl:with-param name="jednostka" select="$instytucja/ns3:Jednostka | $instytucja/inst:Jednostka"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="count($instytucja/ns4:Adres | $instytucja/adr:Adres) &gt; 0">
			<xsl:call-template name="Adres">
				<xsl:with-param name="adres" select="$instytucja/ns4:Adres | $instytucja/adr:Adres"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="count($instytucja/ns3:IdInstytucji | $instytucja/inst:IdInstytucji) &gt; 0">
			<xsl:call-template name="PodmiotIdentyfikatory">
				<xsl:with-param name="id" select="$instytucja/ns3:IdInstytucji | $instytucja/inst:IdInstytucji"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="count($instytucja/ns4:Kontakt | $instytucja/adr:Kontakt) &gt; 0">
			<xsl:call-template name="PodmiotKontakt">
				<xsl:with-param name="kontakt" select="$instytucja/ns4:Kontakt | $instytucja/adr:Kontakt"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="Podmioty">
		<xsl:param name="podmiot" select="wnio:DaneDokumentu/str:Adresaci"/>
		<xsl:param name="inline" select="'false'"/>
		<xsl:for-each select="$podmiot/ns2:Podmiot | $podmiot/meta:Podmiot">
			<xsl:if test="oso:Osoba">
				<xsl:call-template name="PodmiotOsoba">
					<xsl:with-param name="osoba" select="oso:Osoba"/>
					<xsl:with-param name="inline" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="ns3:Instytucja | inst:Instytucja">
				<xsl:call-template name="PodmiotInstytucja">
					<xsl:with-param name="instytucja" select="ns3:Instytucja | inst:Instytucja"/>
					<xsl:with-param name="inline" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="PodmiotJednostka">
		<xsl:param name="jednostka"/>
		<xsl:param name="inline"/>
		<xsl:if test="string-length($jednostka/ns3:NazwaInstytucji | $jednostka/inst:NazwaInstytucji) &gt; 0">
			<xsl:value-of select="$jednostka/ns3:NazwaInstytucji | $jednostka/inst:NazwaInstytucji"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$jednostka/ns3:Jednostka | $jednostka/inst:Jednostka">
			<xsl:call-template name="PodmiotJednostka">
				<xsl:with-param name="jednostka" select="$jednostka/ns3:Jednostka | $jednostka/inst:Jednostka"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="Adres">
		<xsl:param name="adres"/>
		<xsl:param name="inline" select="'false'"/>
		<xsl:if test="string-length($adres/ns4:KodPocztowy | $adres/adr:KodPocztowy) &gt; 0 or string-length($adres/ns4:Miejscowosc | $adres/adr:Miejscowosc) &gt; 0 or string-length($adres/ns4:Poczta | $adres/adr:Poczta) &gt; 0">
			<xsl:if test="string-length($adres/ns4:KodPocztowy | $adres/adr:KodPocztowy) &gt; 0">
				<xsl:value-of select="$adres/ns4:KodPocztowy | $adres/adr:KodPocztowy"/>
				<xsl:value-of select="' '"/>
			</xsl:if>
			<xsl:if test="string-length($adres/ns4:Poczta | $adres/adr:Poczta) &gt; 0">
				<xsl:value-of select="$adres/ns4:Poczta | $adres/adr:Poczta"/>
				<xsl:call-template name="InLine">
					<xsl:with-param name="value" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:value-of select="$adres/ns4:Miejscowosc | $adres/adr:Miejscowosc"/>
			<xsl:if test="string-length($adres/ns4:Ulica | $adres/adr:Ulica) = 0">
				<xsl:value-of select="' '"/>
				<xsl:value-of select="$adres/ns4:Budynek | $adres/adr:Budynek"/>
				<xsl:if test="string-length($adres/ns4:Budynek | $adres/adr:Budynek) &gt; 0">
					<xsl:if test="string-length($adres/ns4:Lokal | $adres/adr:Lokal) &gt; 0">
						<xsl:value-of select="' '"/>/<xsl:value-of select="' '"/>
						<xsl:value-of select="$adres/ns4:Lokal | $adres/adr:Lokal"/>
					</xsl:if>
				</xsl:if>
			</xsl:if>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="string-length($adres/ns4:Ulica | $adres/adr:Ulica) &gt; 0">
			<xsl:value-of select="$adres/ns4:Ulica | $adres/adr:Ulica"/>
			<xsl:value-of select="' '"/>
			<xsl:value-of select="$adres/ns4:Budynek | $adres/adr:Budynek"/>
			<xsl:if test="string-length($adres/ns4:Lokal | $adres/adr:Lokal) &gt; 0">
				<xsl:value-of select="' '"/>/<xsl:value-of select="' '"/>
				<xsl:value-of select="$adres/ns4:Lokal | $adres/adr:Lokal"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="string-length($adres/ns4:Wojewodztwo | $adres/adr:Wojewodztwo) &gt; 0">
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
			<xsl:value-of select="concat('Województwo: ',$adres/ns4:Wojewodztwo | $adres/adr:Wojewodztwo)"/>
		</xsl:if>
		<xsl:if test="string-length($adres/ns4:Powiat | $adres/adr:Powiat) &gt; 0">
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
			<xsl:value-of select="concat('Powiat: ',$adres/ns4:Powiat | $adres/adr:Powiat)"/>
		</xsl:if>
		<xsl:if test="string-length($adres/ns4:Gmina | $adres/adr:Gmina) &gt; 0">
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
			<xsl:value-of select="concat('Gmina: ',$adres/ns4:Gmina | $adres/adr:Gmina)"/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="InLine">
		<xsl:param name="value" select="'true'"/>
		<xsl:choose>
			<xsl:when test="$value='false'">
				<br/>
			</xsl:when>
			<xsl:otherwise>, </xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="Oswiadczenia">
		<xsl:param name="oswiadczenia" select="ns6:TrescDokumentu/ns6:Oswiadczenia | wnio:TrescDokumentu/wnio:Oswiadczenia"/>
		<xsl:if test="count($oswiadczenia/ns6:Oswiadczenie[string-length(text()) &gt; 0] | $oswiadczenia/wnio:Oswiadczenie[string-length(text()) &gt; 0]) &gt; 0">
			<div style="text-align: left;">
				<h2 class="acc">Oświadczenia:</h2>
				<xsl:for-each select="$oswiadczenia/ns6:Oswiadczenie[string-length(text()) &gt; 0] | $oswiadczenia/wnio:Oswiadczenie[string-length(text()) &gt; 0]">
					<p>
						<span>
							<xsl:value-of select="."/>
						</span>
					</p>
				</xsl:for-each>
			</div>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="InformacjeDodatkowe">
		<xsl:param name="informacje" select="wnio:TrescDokumentu/wnio:Informacje"/>
		<xsl:for-each select="$informacje/ns6:Informacja | $informacje/wnio:Informacja">
			<xsl:if test="string-length(.) &gt; 0">
				<p style="text-align: justify;font-size: 11px;font-family: Verdana;line-height: 20px;">
					<xsl:value-of select="."/>
				</p>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="DoWiadomosci">
		<xsl:param name="dowiadomosci" select="ns6:TrescDokumentu/ns6:DoWiadomosci | wnio:TrescDokumentu/wnio:DoWiadomosci"/>
		<xsl:if test="count($dowiadomosci/ns2:Podmiot | $dowiadomosci/meta:Podmiot) &gt; 0">
			<div style="text-align: left;">
				<p style="font-size: 11px;font-family: Verdana;line-height: 20px;margin: 0px;padding:0px">Do wiadomości:</p>
				<ol style="padding-top: 0px;margin-top: 0px;">
					<xsl:for-each select="$dowiadomosci/ns2:Podmiot | $dowiadomosci/meta:Podmiot">
						<li>
							<xsl:choose>
								<xsl:when test="ns3:Instytucja | inst:Instytucja">
									<xsl:call-template name="PodmiotInstytucja">
										<xsl:with-param name="instytucja" select="ns3:Instytucja | inst:Instytucja"/>
										<xsl:with-param name="inline" select="'true'"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="oso:Osoba">
									<xsl:call-template name="PodmiotOsoba">
										<xsl:with-param name="osoba" select="oso:Osoba"/>
										<xsl:with-param name="inline" select="'true'"/>
									</xsl:call-template>
								</xsl:when>
							</xsl:choose>
						</li>
					</xsl:for-each>
				</ol>
			</div>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="Upowaznienie">
		<xsl:param name="upo" select="ns6:TrescDokumentu/ns6:Podpis | wnio:TrescDokumentu/wnio:Podpis"/>
		<div align="right" style="text-align: right;font-size: 10px;font-family: Verdana;line-height: 20px;">
			<table style="float: right;">
				<tr>
					<td style="width: 340px;">
						<p align="center" style="text-align: center;font-size: 10px;font-family: Verdana;line-height: 20px;">
							<xsl:if test="string-length($upo/ns6:ZUpowaznienia | $upo/wnio:ZUpowaznienia) &gt; 0">
                Z upoważnienia
                <xsl:value-of select="' '"/>
								<xsl:value-of select="$upo/ns6:ZUpowaznienia | $upo/wnio:ZUpowaznienia"/>
								<br/>
							</xsl:if>
							<xsl:value-of select="$upo/oso:Imie"/>
							<xsl:for-each select="$upo/oso:ImieDrugie">
								<xsl:value-of select="' '"/>
								<xsl:value-of select="."/>
							</xsl:for-each>
							<xsl:for-each select="$upo/oso:Nazwisko">
								<xsl:value-of select="' '"/>
								<xsl:value-of select="."/>
							</xsl:for-each>
							<xsl:if test="string-length($upo/ns6:Stanowisko | $upo/wnio:Stanowisko) &gt; 0">
								<br/>
								<xsl:value-of select="$upo/ns6:Stanowisko | $upo/wnio:Stanowisko"/>
							</xsl:if>
						</p>
					</td>
				</tr>
			</table>
			<div style="clear: both;"/>
		</div>
	</xsl:template>

	<xsl:template name="Podpis">
		<div align="right" style="text-align: right;font-size: 10px;font-family: Verdana;line-height: 20px;">
			<table style="float: right;">
				<tr>
					<td style="width: 340px;">
						<h2 class="acc">Podpisy elektroniczne</h2>
						<p align="center" style="text-align: center;font-size: 10px;font-family: Verdana;line-height: 20px;">
							<xsl:choose>
								<xsl:when test="string-length(//ns6:Dokument/ds:Signature/ds:SignatureValue | //wnio:Dokument/ds:Signature/ds:SignatureValue) &gt; 0">
									<xsl:text>Dokument został podpisany, aby go zweryfikować należy użyć oprogramowania do weryfikacji podpisu</xsl:text>
									<xsl:choose>
										<xsl:when test="count(//ns6:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime'] | //wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']) &gt; 1">
											<br/>
											<xsl:text>Daty złożenia podpisu: </xsl:text>
											<xsl:for-each select="//ns6:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime'] | //wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']">
												<xsl:call-template name="FormatujDate">
													<xsl:with-param name="data" select="."/>
												</xsl:call-template>
												<xsl:if test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:if>
											</xsl:for-each>
										</xsl:when>
										<xsl:when test="count(//ns6:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime'] | //wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']) = 1">
											<br/>
											<xsl:text>Data złożenia podpisu: </xsl:text>
											<xsl:for-each select="//ns6:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime'] | //wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']">
												<xsl:call-template name="FormatujDate">
													<xsl:with-param name="data" select="."/>
												</xsl:call-template>
											</xsl:for-each>
										</xsl:when>
										<xsl:when test="0 &gt;= count(//ns6:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime'] | //wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime'])">
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>Dokument nie zawiera podpisu</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<br/>
							<span style="font-size: 7pt;font-weight: bold;">
								Podpis elektroniczny
							</span>
						</p>
					</td>
				</tr>
			</table>
		</div>
		<div style="clear: both;"/>
	</xsl:template>
	
	<xsl:template name="RodzajDokumentu">
		<xsl:param name="rodzaj" select="ns6:TrescDokumentu/ns6:RodzajWnioskuRozszerzony/@rodzaj | wnio:TrescDokumentu/wnio:RodzajWnioskuRozszerzony/@rodzaj"/>
		<xsl:param name="jakiInny" select="ns6:TrescDokumentu/ns6:RodzajWnioskuRozszerzony/@jakiInny | wnio:TrescDokumentu/wnio:RodzajWnioskuRozszerzony/@jakiInny"/>
		<!-- jesli typ predefiniowany, wypisz -->
		<xsl:if test="$rodzaj != 'inne pismo'">
			<h2 style="text-align: center; font-size: 12px; line-height: 20px; text-transform: uppercase; font-weight: normal;">
				<xsl:value-of select="$rodzaj"/>
			</h2>
		</xsl:if>
		<!-- jesli 'inne pismo' i podano jakie, wypisz -->
		<xsl:if test="$rodzaj = 'inne pismo' and $jakiInny != ''">
			<h2 style="text-align: center; font-size: 12px; line-height: 20px; text-transform: uppercase; font-weight: normal;">
				<xsl:value-of select="$jakiInny"/>
			</h2>
		</xsl:if>
		<!-- w przeciwnym razie bez h1 -->
	</xsl:template>
	
	<xsl:template name="TytulDokumentu">
		<xsl:param name="tytul" select="ns6:TrescDokumentu/ns6:Tytul | wnio:TrescDokumentu/wnio:Tytul"/>
		<h3 style="text-align: center;font-size: 12px; line-height: 20px; font-weight: normal;">
			<xsl:value-of select="$tytul"/>
		</h3>
	</xsl:template>
</xsl:stylesheet>