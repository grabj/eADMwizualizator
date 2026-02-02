<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:adr="http://crd.gov.pl/xml/schematy/adres/2009/11/09/" xmlns:oso="http://crd.gov.pl/xml/schematy/osoba/2009/11/16/" xmlns:inst="http://crd.gov.pl/xml/schematy/instytucja/2009/11/16/" xmlns:meta="http://crd.gov.pl/xml/schematy/meta/2009/11/16/" xmlns:str="http://crd.gov.pl/xml/schematy/struktura/2009/11/16/" xmlns:wnio="http://crd.gov.pl/wzor/2017/10/24/4566/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns="http://www.w3.org/1999/xhtml" version="1.0" xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform http://www.w3.org/2005/02/schema-for-xslt20.xsd" exclude-result-prefixes="adr oso inst meta wnio ds str xsi">
	<xsl:output method="xml" encoding="utf-8" indent="yes" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
	<xsl:template match="/">
		<xsl:apply-templates select="wnio:Dokument"/>
	</xsl:template>
	<xsl:template match="wnio:Dokument">
		<xsl:param name="tresc" select="wnio:TrescDokumentu"/>
		<html lang="pl">

		<head>
			<meta name="viewport" content="width=device-width, initial-scale=1"/>
			<title>Pismo ogólne do podmiotu publicznego</title>
			<style type="text/css">
				/* przedrostek du - dokumenty urzędowe
          index:
          1. reset style and font size
          2. style for tags
          3. grid and style for dotted
          4. screen reader only
          5. header
          6. other style
          7. print
          8. screen (max-width: 650px)
          9. screen (min-width: 651px) and (max-width: 1024px)
          */
				/*reset style and font size*/

				main&gt;
				div,
				span,
				h1,
				h2,
				h3,
				h4,
				h5,
				h6,
				p,
				a,
				address,
				img,
				ol,
				ul,
				li,
				fieldset,
				form,
				label,
				legend,
				footer,
				header,
				section,
				input {
					margin: 0;
					padding: 0;
					border: 0;
					font-size: 100%;
					font: inherit;
					vertical-align: baseline;
				}

				main&gt; article,
				footer,
				header,
				section {
					display: block;
				}

				body {
					font-family: Arial, Helvetica, sans-serif;
					font-size: 14px;
					line-height: 1;
				}

				main&gt; ol,
				ul {
					list-style: none;
				}

				* {
					-webkit-box-sizing: border-box;
					-moz-box-sizing: border-box;
					box-sizing: border-box;
				}
				/*style for tags*/

				main {
					width: 100%;
					height: 100%;
					padding: 1%;
					line-height: 130%;
				}

				h1 {
					font-size: 18px;
					font-weight: bold;
				}

				h2,
				h4,
				h5,
				h6 {
					font-size: 14px;
					font-weight: bold;
				}

				h3 {
					font-size: 14px;
					font-weight: bold;
					margin-top: 1%;
				}

				div {
					display: inline-block;
					word-wrap: break-word;
					margin-top: 0.5%;
					padding: 0.5%;
				}

				input {
					margin-top: 0.5%;
					margin-right: 0.5%;
				}

				input:checked {
					outline: 2px solid black;
				}
				/*grid and style for dotted*/

				.du-col-1 {
					width: 8.33%;
				}

				.du-col-2 {
					width: 16.66%;
					padding-right: 1.1%;
				}

				.du-col-2-dotted {
					width: 16.25%;
					padding-right: 1.1%;
				}

				.du-col-3 {
					width: 25%;
				}

				.du-col-4 {
					width: 33.33%;
				}

				.du-col-5 {
					width: 41.66%;
				}

				.du-col-6 {
					width: 50%;
				}

				.du-col-7 {
					width: 58.33%;
				}

				.du-col-8 {
					width: 66.66%;
				}

				.du-col-9 {
					width: 75%;
				}

				.du-col-10 {
					width: 83.33%;
				}

				.du-col-10-dotted {
					width: 84.33%;
				}

				.du-col-11 {
					width: 91.66%;
				}

				.du-col-12 {
					width: 100%;
				}

				.du-no-left-column {
					margin-top: 0.1%;
					margin-left: 16.66%;
					padding: 0.2%;
				}

				.du-no-left-column-dotted {
					margin-left: 16.25%;
				}

				.du-p-mobile {
					margin-right: 2.5%;
				}

				.du-city-width {
					width: 40%;
					text-align: left;
					padding: 1.1%;
				}

				.du-border-dotted {
					border: 2px dotted #c0c0c0;
				}
				/*screen reader only*/

				.du-sr-only {
					position: absolute;
					width: 1px;
					height: 1px;
					margin: -1px;
					padding: 0;
					overflow: hidden;
					clip: rect(0, 0, 0, 0);
					border: 0;
				}
				/*header*/

				.du-header-eagle-table {
					float: left;
					margin-right: 0px;
					margin-top: 21px;
					padding: 0;
					margin-bottom: 15px;
				}

				.du-header-eagle-RP {
					font-size: 18px;
					margin-top: 28px;
					line-height: 135%;
				}

				.du-header-eagle-img {
					width: 70px;
					height: 70px;
				}

				.du-header-nr-table {
					float: right;
					margin-right: 0px;
					margin-top: 21px;
					padding: 0;
					margin-bottom: 15px;
				}

				.du-header-nr-document {
					min-width: 300px;
					min-height: 45px;
					border: 3px solid black;
					font-size: 18px;
					text-align: center;
					font-weight: bold;
					padding: 9px;
				}

				.du-header-nr-grey {
					margin-top: 0px;
					min-width: 300px;
					min-height: 45px;
					background-color: #dcdcdc;
				}
				/*other style*/

				.du-no-mt {
					margin-top: 0;
				}

				.du-margin-left {
					margin-left: 3%;
				}

				.du-no-padding {
					padding: 0;
				}

				.du-small-padding {
					padding: 0.1%;
				}

				.du-padding-bottom {
					padding-bottom: 0;
				}

				.du-padding-right {
					padding-right: 0
				}

				.du-box-padding {
					padding: 1.1%;
					padding-right: 1.5%;
					min-width: 30px;
				}

				.du-box-right {
					float: right;
					width: 70%;
					margin: 0;
				}

				.du-left {
					text-align: left;
					float: left;
				}

				.du-right {
					text-align: right;
					float: left;
				}

				.du-center {
					text-align: center;
				}

				.du-uppercase {
					text-transform: uppercase;
				}

				.du-line {
					border-bottom: 2px solid black;
					;
				}

				.du-border {
					border: 1px solid black;
					min-width: 33px;
					min-height: 38px;
					margin-bottom: 1px;
				}

				.du-italic {
					font-style: italic;
				}

				.du-bold {
					font-weight: bold;
				}
				.du-preline{
				white-space: pre-line;
				}

				@media print {
					main {
						font-size: 12px;
					}
					h3 {
						font-size: 14px;
						font-weight: bold;
						margin-top: 1%;
						margin-bottom: 0;
					}
					div {
						padding: 1%;
						min-height: 30px;
					}
					input {
						margin-top: 1%;
						margin-right: 3%;
					}
					.du-col-2 {
						width: 26.66%;
					}
					.du-col-2-dotted {
						width: 26.25%;
					}
					.du-col-5 {
						width: 36.66%;
					}
					.du-col-6 {
						width: 50%
					}
					.du-col-10 {
						width: 73.33%;
					}
					.du-col-10-dotted {
						width: 74.33%;
					}
					.du-no-left-column {
						margin-top: 0.5%;
						margin-left: 26.66%;
					}
					.du-no-left-column-dotted {
						margin-left: 26.25%;
					}
					.du-city-width {
						margin-bottom: 10px;
					}
					.du-box-padding {
						min-width: 18px;
						padding: 2%;
					}
					.du-border {
						min-width: 18px;
						min-height: 30px;
					}
					.du-header-nr-table {
						margin-top: 10px;
					}
					.du-header-nr-grey {
						margin-top: 0px;
						min-width: 300px;
						height: 45px;
						background-color: #dcdcdc;
						box-shadow: inset 0 0 0 30px #dcdcdc;
					}
				}

				@media screen and (max-width: 650px) {
					div {
						margin-top: 2%;
					}
					.du-col-2 {
						width: 100%;
						padding-right: 1.1%;
					}
					.du-col-2-dotted {
						width: 99.25%;
						padding-right: 1.1%;
					}
					.du-col-5 {
						width: 100%;
					}
					.du-col-6 {
						width: 100%
					}
					.du-right {
						text-align: left;
						float: left;
					}
					.du-col-10 {
						width: 100%;
					}
					.du-col-10-dotted {
						width: 99.25%;
					}
					.du-no-left-column {
						margin-left: 0;
					}
					.du-no-left-column-dotted {
						margin-left: 0;
					}
					.du-box-padding {
						min-width: 23px;
					}
					.du-box-right {
						width: 100%;
					}
					.du-p-mobile {
						width: 100%;
						display: inline-block;
						text-align: left;
					}
					.du-header-nr-table {
						float: left;
						margin-top: 1px;
						margin-bottom: 1px;
					}
					.du-header-eagle-table {
						margin-top: 1px;
						margin-bottom: 1px;
					}
					.du-header-eagle-RP {
						font-size: 18px;
						margin-top: 12px;
						line-height: 135%;
					}
					.du-border {
						min-width: 23px;
						min-height: 25px;
					}
				}

				@media screen and (min-width: 651px) and (max-width: 1024px) {
					.du-col-2 {
						width: 100%;
						padding-right: 1.1%;
					}
					.du-col-2-dotted {
						width: 16.25%;
						padding-right: 1.1%;
					}

					.du-right-tablet {
						text-align: right;
					}
					.du-col-10 {
						width: 100%;
					}
					.du-col-10-dotted {
						width: 99.25%;
					}
					.du-no-left-column {
						margin-left: 0;
					}
					.du-no-left-column-dotted {
						margin-left: 0;
					}
					.du-box-padding {
						min-width: 20px;
					}
					.du-box-right {
						width: 100%;
					}
					.du-border {
						min-width: 23px;
						min-height: 25px;
					}
				}
			</style>
		</head>

		<body>
			<main>
				<section>
					


						<div class="du-col-12 du-left du-line">
							<h1>Dokument elektroniczny</h1>
						</div>
					
				</section>

				<xsl:call-template name="NaglowekStandard"/>
				<xsl:if test="string-length(wnio:DaneDokumentu/str:Naglowek/str:NazwaDokumentu) &gt; 0">

					<xsl:value-of select="wnio:DaneDokumentu/str:Naglowek/str:NazwaDokumentu"/>

				</xsl:if>
				<xsl:call-template name="RodzajDokumentu"/>
				<xsl:call-template name="TytulDokumentu"/>
				<xsl:for-each select="$tresc/wnio:Informacje/wnio:Informacja">
				<section>
				<div class="du-col-12 du-left du-preline" style="">
					<xsl:if test="string-length(.) &gt; 0">
						<xsl:value-of select="."/>
					</xsl:if>
					</div>
				</section>	
				</xsl:for-each>
				<xsl:call-template name="Oswiadczenia"/>
				<xsl:call-template name="InformacjeDodatkowe">
					<xsl:with-param name="informacje" select="$tresc/wnio:InformacjeDodatkowe"/>
				</xsl:call-template>
				<xsl:call-template name="Upowaznienie"/>
				<xsl:call-template name="Zalaczniki"/>
				<xsl:call-template name="DoWiadomosci"/>
				<xsl:call-template name="Podpis"/>
			</main>
		</body>

		</html>
	</xsl:template>

	<xsl:template name="NaglowekStandard">

		<section>

			<div class="du-col-12 du-right">
				<h2>Miejsce i data sporządzenia dokumentu</h2>
				<xsl:call-template name="MiejscowoscData"/>
			</div>

			<div class="du-col-6 du-left">
				<h2>Dane nadawcy</h2>
				<xsl:call-template name="Podmioty">
					<xsl:with-param name="podmiot" select="wnio:DaneDokumentu/str:Nadawcy"/>
				</xsl:call-template>
			</div>

			<div class="du-col-6 du-right">
				<h2>Dane adresata</h2>
				<xsl:call-template name="Podmioty">
					<xsl:with-param name="podmiot" select="wnio:DaneDokumentu/str:Adresaci"/>
				</xsl:call-template>
			</div>
			<div class="du-col-12 du-left">
				<xsl:if test="string-length(wnio:DaneDokumentu/str:Naglowek/meta:Identyfikator/meta:Wartosc) &gt; 0">

					<xsl:value-of select="wnio:DaneDokumentu/str:Naglowek/meta:Identyfikator/meta:Wartosc"/>

				</xsl:if>

			</div>

		</section>


	</xsl:template>
	<xsl:template name="Zalaczniki">
		<xsl:param name="zalaczniki" select="wnio:TrescDokumentu/str:Zalaczniki"/>
		<xsl:if test="count($zalaczniki/str:Zalacznik) &gt; 0">
			<section>
				<div class="du-col-12 du-right">
					<h2>Załączniki:</h2>
					<ol>
						<xsl:for-each select="$zalaczniki/str:Zalacznik[@nazwaPliku != '']">
							<li>
								<xsl:if test="@kodowanie='base64'">
									<xsl:value-of select="@nazwaPliku"/>
									<xsl:if test="string-length(str:OpisZalacznika) &gt; 0"> - </xsl:if>
									<xsl:if test="string-length(str:OpisZalacznika) &gt; 0">
										<xsl:value-of select="str:OpisZalacznika"/>
									</xsl:if>
								</xsl:if>
								<xsl:if test="@kodowanie='URI'">
									<a href="{str:DaneZalacznika}">
										<xsl:value-of select="@nazwaPliku"/>
									</a>
									<xsl:if test="string-length(str:OpisZalacznika) &gt; 0"> - </xsl:if>
									<xsl:if test="string-length(str:OpisZalacznika) &gt; 0">
										<xsl:value-of select="str:OpisZalacznika"/>
									</xsl:if>
								
								</xsl:if>
							</li>
						</xsl:for-each>
					</ol>
				</div>
			</section>
		</xsl:if>
	</xsl:template>



	<xsl:template name="MiejscowoscData">
		<xsl:param name="miejscowosc" select="wnio:TrescDokumentu/wnio:MiejscowoscDokumentu"/>
		<xsl:param name="data" select="wnio:DaneDokumentu/meta:Data[@typDaty='stworzony']/meta:Czas"/>
		<section>
			<div class="du-col-12 du-right">
				<xsl:value-of select="$miejscowosc"/>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="$data"/>
			</div>
		</section>


	</xsl:template>
	<xsl:template name="PodmiotKontakt">
		<xsl:param name="kontakt" select="adr:Kontakt"/>
		<xsl:param name="inline" select="'false'"/>

		<xsl:for-each select="$kontakt/adr:Telefon">
			<xsl:if test="string-length(.) &gt; 0">

				<xsl:value-of select="concat('Telefon: ',.)"/>
				<xsl:call-template name="InLine">
					<xsl:with-param name="value" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="$kontakt/adr:Faks">
			<xsl:if test="string-length(.) &gt; 0">
				<xsl:value-of select="concat('Faks: ',.)"/>
				<xsl:call-template name="InLine">
					<xsl:with-param name="value" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="$kontakt/adr:Email">
			<xsl:if test="string-length(.) &gt; 0">
				<xsl:value-of select="concat('Email: ',.)"/>
				<xsl:call-template name="InLine">
					<xsl:with-param name="value" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="$kontakt/adr:URIKontakt">
			<xsl:if test="string-length(.) &gt; 0">
				<xsl:value-of select="concat('',.)"/>
				<xsl:call-template name="InLine">
					<xsl:with-param name="value" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="$kontakt/adr:InnyKontakt">
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
		<xsl:if test="string-length($id/inst:KRS) &gt; 0">
			<xsl:value-of select="concat('KRS: ',$id/inst:KRS)"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="string-length($id/inst:NIP) &gt; 0">
			<xsl:value-of select="concat('NIP: ',$id/inst:NIP)"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="string-length($id/inst:REGON) &gt; 0">
			<xsl:value-of select="concat('REGON: ',$id/inst:REGON)"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="string-length($id/inst:InnyIdentyfikator/inst:WartoscIdentyfikatora) &gt; 0">
			<xsl:if test="string-length($id/inst:InnyIdentyfikator/inst:TypIdentyfikatora) &gt; 0">
				<xsl:value-of select="$id/inst:InnyIdentyfikator/inst:TypIdentyfikatora"/>
				<xsl:value-of select="': '"/>
			</xsl:if>
			<xsl:value-of select="$id/inst:InnyIdentyfikator/inst:WartoscIdentyfikatora"/>
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
		<xsl:if test="count($osoba/adr:Adres) &gt; 0">
			<xsl:call-template name="Adres">
				<xsl:with-param name="adres" select="$osoba/adr:Adres"/>
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
		<xsl:if test="count($osoba/adr:Kontakt) &gt; 0">
			<xsl:call-template name="PodmiotKontakt">
				<xsl:with-param name="kontakt" select="$osoba/adr:Kontakt"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PodmiotInstytucja">
		<xsl:param name="instytucja" select="wnio:DaneDokumentu/str:Adresaci/meta:Podmiot/inst:Instytucja"/>
		<xsl:param name="inline" select="'false'"/>
		<xsl:if test="string-length($instytucja/inst:NazwaInstytucji) &gt; 0">
			<xsl:value-of select="$instytucja/inst:NazwaInstytucji"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$instytucja/inst:Jednostka">
			<xsl:call-template name="PodmiotJednostka">
				<xsl:with-param name="jednostka" select="$instytucja/inst:Jednostka"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="count($instytucja/adr:Adres) &gt; 0">
			<xsl:call-template name="Adres">
				<xsl:with-param name="adres" select="$instytucja/adr:Adres"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="count($instytucja/inst:IdInstytucji) &gt; 0">
			<xsl:call-template name="PodmiotIdentyfikatory">
				<xsl:with-param name="id" select="$instytucja/inst:IdInstytucji"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="count($instytucja/adr:Kontakt) &gt; 0">
			<xsl:call-template name="PodmiotKontakt">
				<xsl:with-param name="kontakt" select="$instytucja/adr:Kontakt"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Podmioty">
		<xsl:param name="podmiot" select="wnio:DaneDokumentu/str:Adresaci"/>
		<xsl:param name="inline" select="'false'"/>
		<xsl:for-each select="$podmiot/meta:Podmiot">
			<xsl:if test="oso:Osoba">
				<xsl:call-template name="PodmiotOsoba">
					<xsl:with-param name="osoba" select="oso:Osoba"/>
					<xsl:with-param name="inline" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="inst:Instytucja">
				<xsl:call-template name="PodmiotInstytucja">
					<xsl:with-param name="instytucja" select="inst:Instytucja"/>
					<xsl:with-param name="inline" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="PodmiotJednostka">
		<xsl:param name="jednostka"/>
		<xsl:param name="inline"/>
		<xsl:if test="string-length($jednostka/inst:NazwaInstytucji) &gt; 0">
			<xsl:value-of select="$jednostka/inst:NazwaInstytucji"/>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$jednostka/inst:Jednostka">
			<xsl:call-template name="PodmiotJednostka">
				<xsl:with-param name="jednostka" select="$jednostka/inst:Jednostka"/>
				<xsl:with-param name="inline" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Adres">
		<xsl:param name="adres"/>
		<xsl:param name="inline" select="'false'"/>
		<xsl:if test="string-length($adres/adr:KodPocztowy) &gt; 0 or string-length($adres/adr:Miejscowosc) &gt; 0 or string-length($adres/adr:Poczta) &gt; 0">
			<xsl:if test="string-length($adres/adr:KodPocztowy) &gt; 0">
				<xsl:value-of select="$adres/adr:KodPocztowy"/>
				<xsl:value-of select="' '"/>
			</xsl:if>
			<xsl:if test="string-length($adres/adr:Poczta) &gt; 0">
				<xsl:value-of select="$adres/adr:Poczta"/>
				<xsl:call-template name="InLine">
					<xsl:with-param name="value" select="$inline"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:value-of select="$adres/adr:Miejscowosc"/>
			<xsl:if test="string-length($adres/adr:Ulica) = 0">
				<xsl:value-of select="' '"/>
				<xsl:value-of select="$adres/adr:Budynek"/>
				<xsl:if test="string-length($adres/adr:Budynek) &gt; 0">
					<xsl:if test="string-length($adres/adr:Lokal) &gt; 0">
						<xsl:value-of select="' '"/>/
						<xsl:value-of select="' '"/>
						<xsl:value-of select="$adres/adr:Lokal"/>
					</xsl:if>
				</xsl:if>
			</xsl:if>
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="string-length($adres/adr:Ulica) &gt; 0">
			<xsl:value-of select="$adres/adr:Ulica"/>
			<xsl:value-of select="' '"/>
			<xsl:value-of select="$adres/adr:Budynek"/>
			<xsl:if test="string-length($adres/adr:Lokal) &gt; 0">
				<xsl:value-of select="' '"/>/
				<xsl:value-of select="' '"/>
				<xsl:value-of select="$adres/adr:Lokal"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="string-length($adres/adr:Wojewodztwo) &gt; 0">
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
			<xsl:value-of select="concat('Województwo: ',$adres/adr:Wojewodztwo)"/>
		</xsl:if>
		<xsl:if test="string-length($adres/adr:Powiat) &gt; 0">
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
			<xsl:value-of select="concat('Powiat: ',$adres/adr:Powiat)"/>
		</xsl:if>
		<xsl:if test="string-length($adres/adr:Gmina) &gt; 0">
			<xsl:call-template name="InLine">
				<xsl:with-param name="value" select="$inline"/>
			</xsl:call-template>
			<xsl:value-of select="concat('Gmina: ',$adres/adr:Gmina)"/>
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
		<xsl:param name="oswiadczenia" select="wnio:TrescDokumentu/wnio:Oswiadczenia"/>

		<xsl:if test="count($oswiadczenia/wnio:Oswiadczenie[string-length(text()) &gt; 0]) &gt; 0">
			<section>

				<div class="du-col-12 du-left">
					<h2>Oświadczenia:</h2>
					<xsl:for-each select="$oswiadczenia/wnio:Oswiadczenie[string-length(text()) &gt; 0]">

						<xsl:value-of select="."/>

					</xsl:for-each>
				</div>
			</section>
		</xsl:if>

	</xsl:template>
	<xsl:template name="InformacjeDodatkowe">
		<xsl:param name="informacje" select="wnio:TrescDokumentu/wnio:Informacje"/>

		<xsl:for-each select="$informacje/wnio:Informacja">
			<xsl:if test="string-length(.) &gt; 0">
				<section>

					<div class="du-col-12 du-left">

						<xsl:value-of select="."/>
					</div>
				</section>
			</xsl:if>
		</xsl:for-each>

	</xsl:template>
	<xsl:template name="DoWiadomosci">
		<xsl:param name="dowiadomosci" select="wnio:TrescDokumentu/wnio:DoWiadomosci"/>
		<xsl:if test="count($dowiadomosci/meta:Podmiot) &gt; 0">
			<section>

				<div class="du-col-12 du-left">
					Do wiadomości:
					<ol>
						<xsl:for-each select="$dowiadomosci/meta:Podmiot">
							<li>
								<xsl:choose>
									<xsl:when test="inst:Instytucja">
										<xsl:call-template name="PodmiotInstytucja">
											<xsl:with-param name="instytucja" select="inst:Instytucja"/>
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
			</section>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Upowaznienie">
		<xsl:param name="upo" select="wnio:TrescDokumentu/wnio:Podpis"/>
		<section>

			<div class="du-col-12 du-left">
				<xsl:if test="string-length($upo/wnio:ZUpowaznienia) &gt; 0">
					Z upoważnienia
					<xsl:value-of select="' '"/>
					<xsl:value-of select="$upo/wnio:ZUpowaznienia"/>

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
				<xsl:if test="string-length($upo/wnio:Stanowisko) &gt; 0">

					<xsl:value-of select="$upo/wnio:Stanowisko"/>

				</xsl:if>
			</div>
		</section>
	</xsl:template>
	<xsl:template name="Podpis">
		<section>

			<div class="du-col-12 du-right">

				<xsl:choose>
					<xsl:when test="string-length(//wnio:Dokument/ds:Signature/ds:SignatureValue) &gt; 0">
						<xsl:text>Dokument został podpisany, aby go zweryfikować należy użyć oprogramowania do weryfikacji podpisu. </xsl:text>
						<xsl:choose>
							<xsl:when test="count(//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']) &gt; 1">

								<xsl:text>Daty złożenia podpisu: </xsl:text>
								<br/>
								<xsl:for-each select="//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']">
									<xsl:value-of select="."/>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="count(//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']) = 1">

								<xsl:text>Data złożenia podpisu: </xsl:text>
								<br/>
								<xsl:for-each select="//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']">
									<xsl:value-of select="."/>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="0 &gt;= count(//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime'])">
							</xsl:when>
						</xsl:choose>

					</xsl:when>
					<xsl:otherwise>
						<br/><div class="du-bold">
						<xsl:text>Dokument nie zawiera podpisu</xsl:text>
						</div><br/>
					</xsl:otherwise>
				</xsl:choose>

	<hr/>
				<div class="du-bold">Podpis elektroniczny</div>

			</div>
		</section>
	</xsl:template>
	<xsl:template name="RodzajDokumentu">
		<xsl:param name="rodzaj" select="wnio:TrescDokumentu/wnio:RodzajWnioskuRozszerzony/@rodzaj"/>
		<xsl:param name="jakiInny" select="wnio:TrescDokumentu/wnio:RodzajWnioskuRozszerzony/@jakiInny"/>

		<xsl:if test="$rodzaj != 'inne pismo'">
			<section>

				<div class="du-col-12 du-center">

					<h2 class="du-uppercase">
						<xsl:value-of select="$rodzaj"/>
					</h2>
				</div>
			</section>
		</xsl:if>

		<xsl:if test="$rodzaj = 'inne pismo' and $jakiInny != ''">
			<section>

				<div class="du-col-12 du-center">

					<h2 class="du-uppercase">
						<xsl:value-of select="$jakiInny"/>
					</h2>
				</div>
			</section>

		</xsl:if>


	</xsl:template>
	<xsl:template name="TytulDokumentu">

		<xsl:param name="tytul" select="wnio:TrescDokumentu/wnio:Tytul"/>
		<section>

			<div class="du-col-12 du-center">
				<h3>
					<xsl:value-of select="$tytul"/>
				</h3>
			</div>
		</section>
	</xsl:template>
</xsl:stylesheet>