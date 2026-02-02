<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:odpowiedz="http://crd.gov.pl/wzor/2014/06/30/1686/"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                version="1.0">
	<xsl:preserve-space elements="*"/>
	<xsl:output method="html" encoding="utf-8" indent="yes"/>
	<xsl:template match="odpowiedz:odpowiedzCRSAPL">
		<html>
			<head>
				<meta charset="utf-8"/>
				<title>Informacja CRS.APL — podsumowanie</title>
				<style>
					body{font-family:Segoe UI, Arial, sans-serif; margin:20px; color:#222;}
					.card{max-width:900px;border:1px solid #ddd;border-radius:6px;padding:18px;box-shadow:0 1px 3px rgba(0,0,0,0.05);}
					.header{display:flex;justify-content:space-between;align-items:center;margin-bottom:12px;}
					.org{font-weight:700;color:#0b4771;}
					.meta{font-size:13px;color:#555;}
					.section{margin-top:12px;}
					.two-col{display:flex;gap:20px;}
					.col{flex:1;}
					table{width:100%;border-collapse:collapse;margin-top:8px;}
					td.label{width:220px;color:#555;padding:6px 8px;background:#f8f8f8;border:1px solid #eee;}
					td.value{padding:6px 8px;border:1px solid #eee;font-weight:600;}
					.note{font-size:12px;color:#666;margin-top:12px;}
				</style>
			</head>
			<body>
				<div class="card">
					<div class="header">
						<div>
							<div class="org">MINISTERSTWO SPRAWIEDLIWOŚCI — Krajowy Rejestr Karny</div>
							<div class="meta">Szybkie podsumowanie informacji</div>
						</div>
						<div class="meta">
							Data wydania:
							<xsl:value-of select="odpowiedz:daneZakresu/odpowiedz:kartoteka/odpowiedz:dataWydaniaInformacji"/>
						</div>
					</div>

					<div class="section">
						<h3>Podstawowe dane osoby</h3>
						<table>
							<tr>
								<td class="label">PESEL</td>
								<td class="value">
									<xsl:value-of select="odpowiedz:osoba/odpowiedz:pesel"/>
								</td>
							</tr>
							<tr>
								<td class="label">Nazwisko (rodowe)</td>
								<td class="value">
									<xsl:value-of select="odpowiedz:osoba/odpowiedz:nazwisko"/>
									<xsl:if test="odpowiedz:osoba/odpowiedz:nazwiskoRodowe and not(odpowiedz:osoba/odpowiedz:nazwiskoRodowe/@xsi:nil='true') and string-length(normalize-space(string(odpowiedz:osoba/odpowiedz:nazwiskoRodowe))) &gt; 0">
										<xsl:text> / </xsl:text>
										<xsl:value-of select="odpowiedz:osoba/odpowiedz:nazwiskoRodowe"/>
									</xsl:if>
								</td>
							</tr>
							<tr>
								<td class="label">Imiona</td>
								<td class="value">
									<xsl:value-of select="odpowiedz:osoba/odpowiedz:imie"/>
									<xsl:variable name="drugie" select="odpowiedz:osoba/odpowiedz:drugieImie"/>
									<xsl:if test="$drugie and not($drugie/@xsi:nil='true') and string-length(normalize-space(string($drugie))) &gt; 0">
										<xsl:text> </xsl:text>
										<xsl:value-of select="$drugie"/>
									</xsl:if>
								</td>
							</tr>
							<tr>
								<td class="label">Data urodzenia</td>
								<td class="value">
									<xsl:value-of select="odpowiedz:osoba/odpowiedz:dataUrodzenia"/>
								</td>
							</tr>
							<tr>
								<td class="label">Miejsce urodzenia</td>
								<td class="value">
									<xsl:value-of select="odpowiedz:osoba/odpowiedz:miejsceUrodzenia"/>
								</td>
							</tr>
							<tr>
								<td class="label">Obywatelstwo</td>
								<td class="value">
									<xsl:value-of select="odpowiedz:osoba/odpowiedz:obywatelstwo"/>
								</td>
							</tr>
							<tr>
								<td class="label">Miejsce zamieszkania</td>
								<td class="value">
									<xsl:value-of select="odpowiedz:osoba/odpowiedz:miejsceZamieszkania"/>
								</td>
							</tr>
						</table>
					</div>

					<div class="section two-col">
						<div class="col">
							<h4>Zakres informacji</h4>
							<table>
								<tr>
									<td class="label">Rodzaj danych</td>
									<td class="value">
										<xsl:value-of select="odpowiedz:osoba/odpowiedz:rodzajDanych"/>
									</td>
								</tr>
								<tr>
									<td class="label">Zakres danych</td>
									<td class="value">
										<xsl:value-of select="odpowiedz:osoba/odpowiedz:zakresDanych"/>
									</td>
								</tr>
								<tr>
									<td class="label">Figuruje w rejestrze</td>
									<td class="value">
										<xsl:value-of select="odpowiedz:osoba/odpowiedz:figurujeWRejestrze"/>
									</td>
								</tr>
							</table>
						</div>
						<div class="col">
							<h4>Kartoteka</h4>
							<table>
								<tr>
									<td class="label">Nazwa kartoteki</td>
									<td class="value">
										<xsl:value-of select="odpowiedz:daneZakresu/odpowiedz:kartoteka/odpowiedz:nazwaKartoteki"/>
									</td>
								</tr>
								<tr>
									<td class="label">Figuruje w kartotece</td>
									<td class="value">
										<xsl:value-of select="odpowiedz:daneZakresu/odpowiedz:kartoteka/odpowiedz:figurujeWKartotece"/>
									</td>
								</tr>
								<tr>
									<td class="label">Osoba przygotowująca</td>
									<td class="value">
										<xsl:value-of select="odpowiedz:daneZakresu/odpowiedz:kartoteka/odpowiedz:osobaPrzygotowujaca"/>
									</td>
								</tr>
								<tr>
									<td class="label">Opłata pobrana</td>
									<td class="value">
										<xsl:value-of select="odpowiedz:daneZakresu/odpowiedz:kartoteka/odpowiedz:oplataPobrana"/>
									</td>
								</tr>
							</table>
						</div>
					</div>

					<xsl:variable name="zalacznikNaz" select="odpowiedz:daneZakresu/odpowiedz:kartoteka/odpowiedz:zalacznik/odpowiedz:nazwa"/>
					<div class="note">
						<xsl:text>Załączony plik: </xsl:text>
						<xsl:choose>
							<xsl:when test="$zalacznikNaz and string-length(normalize-space(string($zalacznikNaz))) &gt; 0">
								<xsl:value-of select="$zalacznikNaz"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>9010935.pdf</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>