<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:wnio="http://formularze.praca.gov.pl/xsd/PSZ-PU/4/"
    xmlns:meta="http://crd.gov.pl/xml/schematy/meta/2009/11/16/"
    xmlns:str="http://crd.gov.pl/xml/schematy/struktura/2009/11/16/"
    xmlns:adr="http://crd.gov.pl/xml/schematy/adres/2009/11/09/"
    xmlns:oso="http://crd.gov.pl/xml/schematy/osoba/2009/11/16/"
    xmlns:inst="http://crd.gov.pl/xml/schematy/instytucja/2009/11/16/"
    exclude-result-prefixes="wnio meta str adr oso inst">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Wizualizacja wniosku</title>
				<style>
					body { font-family: Arial, sans-serif; margin: 20px; font-size: 12px; }
					h1 { font-size: 18px; margin-bottom: 15px; }
					h2 { background-color: #f0f0f0; padding: 5px; font-size: 14px; margin-top: 15px; margin-bottom: 10px; }
					h3 { font-size: 13px; margin-top: 12px; margin-bottom: 8px; }
					table { border-collapse: collapse; width: 100%; max-width: 800px; margin-bottom: 15px; font-size: 11px; table-layout: fixed; }
					td, th { border: 1px solid #ccc; padding: 6px; text-align: left; word-wrap: break-word; }
					th { background-color: #f8f8f8; font-weight: 600; width: 30%; }
					td { width: 70%; }
					p { font-size: 12px; margin: 8px 0; }
					ul { font-size: 11px; margin: 8px 0; padding-left: 20px; }
					li { margin-bottom: 4px; }
				</style>
			</head>
			<body>
				<h1>Wizualizacja wniosku PSZ-PU</h1>

				<h2>Opis dokumentu</h2>
				<p>
					Opis dokumentu: <b>
						<xsl:value-of select="//meta:OpisDokumentu"/>
					</b>
				</p>
				<p>Wizualizacja stworzona przez WUW Oddział Obiegu Dokumentów</p>
				<table>
					<tr>
						<th>Nazwa dokumentu</th>
						<td>
							<xsl:value-of select="//str:NazwaDokumentu"/>
						</td>
					</tr>
					<tr>
						<th>Numer wniosku</th>
						<td>
							<xsl:value-of select="//meta:Identyfikator[@typIdentyfikatora='numerWniosku']/meta:Wartosc"/>
						</td>
					</tr>
					<tr>
						<th>Wersja</th>
						<td>
							<xsl:value-of select="//meta:Identyfikator[@typIdentyfikatora='wersjaSc']/meta:Wartosc"/>
						</td>
					</tr>
				</table>

				<h2>Adresat</h2>
				<table>
					<tr>
						<th>Instytucja</th>
						<td>
							<xsl:value-of select="//inst:NazwaInstytucji"/>
						</td>
					</tr>
					<tr>
						<th>Adres</th>
						<td>
							<xsl:value-of select="//adr:Ulica"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="//adr:Budynek"/>
							<xsl:text>, </xsl:text>
							<xsl:variable name="kod" select="//adr:KodPocztowy"/>
							<xsl:value-of select="substring($kod, 1, 2)"/>
							<xsl:text>-</xsl:text>
							<xsl:value-of select="substring($kod, 3, 3)"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="//adr:Miejscowosc"/>
						</td>
					</tr>
				</table>

				<h2>Nadawca</h2>
				<table>
					<tr>
						<th>Imię</th>
						<td>
							<xsl:value-of select="//*[local-name()='Nadawcy']//oso:Imie"/>
						</td>
					</tr>
					<tr>
						<th>Nazwisko</th>
						<td>
							<xsl:value-of select="//*[local-name()='Nadawcy']//oso:Nazwisko"/>
						</td>
					</tr>
					<tr>
						<th>PESEL</th>
						<td>
							<xsl:value-of select="//*[local-name()='Nadawcy']//oso:PESEL"/>
						</td>
					</tr>
					<tr>
						<th>Email</th>
						<td>
							<xsl:value-of select="//*[local-name()='Nadawcy']//adr:Email"/>
						</td>
					</tr>
					<tr>
						<th>Telefon</th>
						<td>
							<xsl:value-of select="//*[local-name()='Nadawcy']//adr:Telefon"/>
						</td>
					</tr>
				</table>

				<h2>Treść wniosku</h2>
				<table>
					<tr>
						<th>Numer wniosku</th>
						<td>
							<xsl:value-of select="//wnio:TrescDokumentu/wnio:NumerWniosku"/>
						</td>
					</tr>
					<tr>
						<th>Miejscowość</th>
						<td>
							<xsl:value-of select="//wnio:TrescDokumentu/wnio:Miejscowosc"/>
						</td>
					</tr>
					<tr>
						<th>Data sporządzenia</th>
						<td>
							<xsl:value-of select="//wnio:TrescDokumentu/wnio:DataSporzadzeniaWniosku"/>
						</td>
					</tr>
					<tr>
						<th>Urząd pracy</th>
						<td>
							<xsl:value-of select="//wnio:TrescDokumentu/wnio:UrzadPracy"/>
						</td>
					</tr>
				</table>

				<h3>Wnioskodawca</h3>
				<table>
					<tr>
						<th>Imię</th>
						<td>
							<xsl:value-of select="//wnio:Wnioskodawca/wnio:Imie"/>
						</td>
					</tr>
					<tr>
						<th>Nazwisko</th>
						<td>
							<xsl:value-of select="//wnio:Wnioskodawca/wnio:Nazwisko"/>
						</td>
					</tr>
					<tr>
						<th>PESEL</th>
						<td>
							<xsl:value-of select="//wnio:Wnioskodawca/wnio:PESEL"/>
						</td>
					</tr>
				</table>

				<h3>Dane adresowe</h3>
				<table>
					<tr>
						<th>Rodzaj adresu</th>
						<td>
							<xsl:value-of select="//wnio:DaneAdresowe/wnio:RodzajAdresu"/>
						</td>
					</tr>
					<tr>
						<th>Adres</th>
						<td>
							<xsl:value-of select="//wnio:DaneAdresowe/wnio:Ulica"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="//wnio:DaneAdresowe/wnio:NrDomu"/>
							<xsl:text>, </xsl:text>
							<xsl:variable name="kod" select="//wnio:DaneAdresowe/wnio:KodPocztowy"/>
							<xsl:value-of select="substring($kod, 1, 2)"/>
							<xsl:text>-</xsl:text>
							<xsl:value-of select="substring($kod, 3, 3)"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="//wnio:DaneAdresowe/wnio:Miejscowosc"/>
						</td>
					</tr>
					<tr>
						<th>Telefon</th>
						<td>
							<xsl:value-of select="//wnio:DaneAdresowe/wnio:Telefon"/>
						</td>
					</tr>
					<tr>
						<th>Email</th>
						<td>
							<xsl:value-of select="//wnio:DaneAdresowe/wnio:Email"/>
						</td>
					</tr>
				</table>

				<h3>Opis sprawy</h3>
				<p>
					<xsl:value-of select="//wnio:OpisSprawy"/>
				</p>

				<h3>Rodzaj sprawy</h3>
				<p>
					<b>
						<xsl:value-of select="//wnio:RodzajSprawy"/>
					</b>
				</p>

				<h3>Data złożenia</h3>
				<p>
					<xsl:value-of select="//wnio:DataZlozeniaWniosku"/>
				</p>

				<h3>Załączniki</h3>
				<ul>
					<xsl:for-each select="//str:Zalacznik">
						<li>
							<xsl:value-of select="@nazwaPliku"/>
						</li>
					</xsl:for-each>
				</ul>
				<br/>

			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>