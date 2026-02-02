<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:pos="http://crd.gov.pl/xml/schematy/UPO/2008/05/09/" xmlns:xades="http://uri.etsi.org/01903/v1.3.2#" xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
	<xsl:output method="html" encoding="UTF-8" />
	<xsl:template match="/">
		<html>
			<head>
				<style type="text/css">.element{ font-family: Arial; font-size: 10pt; color: #800000; }</style>
				<style type="text/css">.tekst{ font-family: Arial; font-size: 10pt; color: #808080; }</style>
				<style type="text/css">.naglowek{ font-family: Arial; font-size: 12pt; font-weight: bold; color: #000000; }</style>
				<style type="text/css">.naglowek2{ font-family: Arial; font-size: 10pt; font-weight: bold; color: #000000; }</style>
				<title>Urzędowe Poświadczenie Odbioru</title>
			</head>
			<body class="tekst">
				<xsl:for-each select="pos:Dokument/pos:UPP">
					<span class="naglowek">
						<xsl:text>UPP - Urzędowe Poświadczenie Przedłożenia</xsl:text>
					</span>
					<br />
					<br />
					<xsl:choose>
						<xsl:when test="pos:IdentyfikatorPoswiadczenia!=''">
							<span class="element">
								<xsl:text>Identyfikator Poświadczenia: </xsl:text>
							</span>
							<xsl:value-of select="pos:IdentyfikatorPoswiadczenia" />
							<br />
							<br />
						</xsl:when>
						<xsl:otherwise />
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="pos:Adresat/pos:Nazwa!=''">
							<span class="naglowek2">
								<xsl:text>Adresat dokumentu, którego dotyczy poświadczenie </xsl:text>
							</span>
							<br />
							<span class="element">
								<xsl:text>Nazwa adresata dokumentu: </xsl:text>
							</span>
							<xsl:value-of select="pos:Adresat/pos:Nazwa" />
							<br />
							<xsl:choose>
								<xsl:when test="pos:Adresat/pos:IdentyfikatorPodmiotu!=''">
									<span class="element">
										<xsl:text>Identyfikator adresata: </xsl:text>
									</span>
									<xsl:value-of select="pos:Adresat/pos:IdentyfikatorPodmiotu" />
									<br />
									<span class="element">
										<xsl:text>Rodzaj identyfikatora adresata: </xsl:text>
									</span>
									<xsl:choose>
										<xsl:when test="pos:Adresat/pos:IdentyfikatorPodmiotu/@TypIdentyfikatora!=''">
											<xsl:value-of select="pos:Adresat/pos:IdentyfikatorPodmiotu/@TypIdentyfikatora" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>-</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise />
							</xsl:choose>
							<br />
							<br />
						</xsl:when>
						<xsl:otherwise />
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="pos:Nadawca/pos:Nazwa!=''">
							<span class="naglowek2">
								<xsl:text>Nadawca dokumentu, którego dotyczy poświadczenie </xsl:text>
							</span>
							<br />
							<span class="element">
								<xsl:text>Nazwa nadawcy: </xsl:text>
							</span>
							<xsl:value-of select="pos:Nadawca/pos:Nazwa" />
							<br />
							<xsl:choose>
								<xsl:when test="pos:Nadawca/pos:IdentyfikatorPodmiotu!=''">
									<span class="element">
										<xsl:text>Identyfikator nadawcy: </xsl:text>
									</span>
									<xsl:value-of select="pos:Nadawca/pos:IdentyfikatorPodmiotu" />
									<br />
									<span class="element">
										<xsl:text>Rodzaj identyfikatora nadawcy: </xsl:text>
									</span>
									<xsl:choose>
										<xsl:when test="pos:Nadawca/pos:IdentyfikatorPodmiotu/@TypIdentyfikatora!=''">
											<xsl:value-of select="pos:Nadawca/pos:IdentyfikatorPodmiotu/@TypIdentyfikatora" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>-</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise />
							</xsl:choose>
							<br />
							<br />
						</xsl:when>
						<xsl:otherwise />
					</xsl:choose>
					<span class="naglowek2">
						<xsl:text>Dane poświadczenia </xsl:text>
					</span>
					<br />
					<xsl:choose>
						<xsl:when test="pos:DataDoreczenia!=''">
							<span class="element">
								<xsl:text>Data doręczenia: </xsl:text>
							</span>
							<xsl:value-of select="pos:DataDoreczenia" />
							<br />
						</xsl:when>
						<xsl:otherwise>
							<p style="color:red">Brak daty doręczenia</p>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="pos:DataWytworzeniaPoswiadczenia!=''">
							<span class="element">
								<xsl:text>Data wytworzenia poświadczenia: </xsl:text>
							</span>
							<xsl:value-of select="pos:DataWytworzeniaPoswiadczenia" />
							<br />
						</xsl:when>
						<xsl:otherwise>
							<p style="color:red">Brak daty wytworzenia poświadczenia</p>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="pos:IdentyfikatorDokumentu!=''">
							<span class="element">
								<xsl:text>Identyfikator dokumentu, którego dotyczy poświadczenie: </xsl:text>
							</span>
							<xsl:value-of select="pos:IdentyfikatorDokumentu" />
							<br />
						</xsl:when>
						<xsl:otherwise>
							<span class="element">
								<xsl:text>Identyfikator dokumentu, którego dotyczy poświadczenie: </xsl:text>
							</span>
							<xsl:text>Brak identyfikator dokumentu</xsl:text>
							<br />
						</xsl:otherwise>
					</xsl:choose>
					<br />
					<span class="naglowek2">
						<xsl:text>Dane uzupełniające (opcjonalne) </xsl:text>
					</span>
					<br />
					<xsl:for-each select="pos:InformacjaUzupelniajaca">
						<span class="element">
							<xsl:text>Rodzaj informacji uzupełniającej: </xsl:text>
						</span>
						<xsl:value-of select="@TypInformacjiUzupelniajacej" />
						<br />
						<span class="element">
							<xsl:text>Wartość informacji uzupełniającej: </xsl:text>
						</span>
						<xsl:value-of select="." />
						<br />
						<br />
					</xsl:for-each>
				</xsl:for-each>
				<br />
				<!--	Czesc UPD -->
				<xsl:for-each select="pos:Dokument/pos:UPD">
					<span class="naglowek">
						<xsl:text>UPD - Urzędowe Poświadczenie Doręczenia</xsl:text>
					</span>
					<br />
					<br />
					<xsl:choose>
						<xsl:when test="pos:IdentyfikatorPoswiadczenia!=''">
							<span class="element">
								<xsl:text>Identyfikator Poświadczenia: </xsl:text>
							</span>
							<xsl:value-of select="pos:IdentyfikatorPoswiadczenia" />
							<br />
							<br />
						</xsl:when>
						<xsl:otherwise />
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="pos:PodmiotWystawiajacyPoswiadczenie/pos:Nazwa!=''">
							<span class="naglowek2">
								<xsl:text>Podmiot wystawiający poświadczenie dla dokumentu </xsl:text>
							</span>
							<br />
							<span class="element">
								<xsl:text>Nazwa wystawcy poświadczenia: </xsl:text>
							</span>
							<xsl:value-of select="pos:PodmiotWystawiajacyPoswiadczenie/pos:Nazwa" />
							<br />
							<xsl:choose>
								<xsl:when test="pos:PodmiotWystawiajacyPoswiadczenie/pos:IdentyfikatorPodmiotu!=''">
									<span class="element">
										<xsl:text>Identyfikator podmiotu: </xsl:text>
									</span>
									<xsl:value-of select="pos:PodmiotWystawiajacyPoswiadczenie/pos:IdentyfikatorPodmiotu" />
									<br />
									<span class="element">
										<xsl:text>Rodzaj identyfikatora podmiotu: </xsl:text>
									</span>
									<xsl:choose>
										<xsl:when test="pos:PodmiotWystawiajacyPoswiadczenie/pos:IdentyfikatorPodmiotu/@TypIdentyfikatora!=''">
											<xsl:value-of select="pos:PodmiotWystawiajacyPoswiadczenie/pos:IdentyfikatorPodmiotu/@TypIdentyfikatora" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>-</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise />
							</xsl:choose>
							<br />
							<br />
						</xsl:when>
						<xsl:otherwise />
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="pos:Adresat/pos:Nazwa!=''">
							<span class="naglowek2">
								<xsl:text>Adresat dokumentu, którego dotyczy poświadczenie </xsl:text>
							</span>
							<br />
							<span class="element">
								<xsl:text>Nazwa adresata dokumentu: </xsl:text>
							</span>
							<xsl:value-of select="pos:Adresat/pos:Nazwa" />
							<br />
							<xsl:choose>
								<xsl:when test="pos:Adresat/pos:IdentyfikatorPodmiotu!=''">
									<span class="element">
										<xsl:text>Identyfikator adresata: </xsl:text>
									</span>
									<xsl:value-of select="pos:Adresat/pos:IdentyfikatorPodmiotu" />
									<br />
									<span class="element">
										<xsl:text>Rodzaj identyfikatora adresata: </xsl:text>
									</span>
									<xsl:choose>
										<xsl:when test="pos:Adresat/pos:IdentyfikatorPodmiotu/@TypIdentyfikatora!=''">
											<xsl:value-of select="pos:Adresat/pos:IdentyfikatorPodmiotu/@TypIdentyfikatora" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>-</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise />
							</xsl:choose>
							<br />
							<br />
						</xsl:when>
						<xsl:otherwise />
					</xsl:choose>
					<span class="naglowek2">
						<xsl:text>Dane poświadczenia </xsl:text>
					</span>
					<br />
					<xsl:choose>
						<xsl:when test="pos:DataOdbioru!=''">
							<span class="element">
								<xsl:text>Data odbioru: </xsl:text>
							</span>
							<xsl:value-of select="pos:DataOdbioru" />
							<br />
						</xsl:when>
						<xsl:otherwise>
							<p style="color:red">Brak daty odbioru</p>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="pos:DataUtworzeniaPoswiadczenia!=''">
							<span class="element">
								<xsl:text>Data utworzenia poświadczenia: </xsl:text>
							</span>
							<xsl:value-of select="pos:DataUtworzeniaPoswiadczenia" />
							<br />
						</xsl:when>
						<xsl:otherwise>
							<p style="color:red">Brak daty wytworzenia poświadczenia</p>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="pos:IdentyfikatorSprawy!=''">
							<span class="element">
								<xsl:text>Identyfikator sprawy, której dotyczy odebrany dokument: </xsl:text>
							</span>
							<xsl:value-of select="pos:IdentyfikatorSprawy" />
							<br />
						</xsl:when>
						<xsl:otherwise>
							<span class="element">
								<xsl:text>Identyfikator sprawy, której dotyczy odebrany dokument:  </xsl:text>
							</span>
							<xsl:text>Brak identyfikator sprawy</xsl:text>
							<br />
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="pos:IdentyfikatorDokumentu!=''">
							<span class="element">
								<xsl:text>Identyfikator dokumentu, którego dotyczy poświadczenie: </xsl:text>
							</span>
							<xsl:value-of select="pos:IdentyfikatorDokumentu" />
							<br />
						</xsl:when>
						<xsl:otherwise>
							<span class="element">
								<xsl:text>Identyfikator dokumentu, którego dotyczy poświadczenie: </xsl:text>
							</span>
							<xsl:text>Brak identyfikator dokumentu</xsl:text>
							<br />
						</xsl:otherwise>
					</xsl:choose>
					<br />
					<span class="naglowek2">
						<xsl:text>Dane uzupełniające (opcjonalne) </xsl:text>
					</span>
					<br />
					<xsl:for-each select="pos:InformacjaUzupelniajaca">
						<span class="element">
							<xsl:text>Rodzaj informacji uzupełniającej: </xsl:text>
						</span>
						<xsl:value-of select="@TypInformacjiUzupelniajacej" />
						<br />
						<span class="element">
							<xsl:text>Wartość informacji uzupełniającej: </xsl:text>
						</span>
						<xsl:value-of select="." />
						<br />
						<br />
					</xsl:for-each>
				</xsl:for-each>
				<!--	Czesc wspolna -->
				<span class="naglowek2">
					<xsl:text>Dane dotyczące podpisu </xsl:text>
				</span>
				<br />
				<xsl:choose>
					<xsl:when test="pos:Dokument/ds:Signature!=''">
						<xsl:text>Poświadczenie zostało podpisane - aby je zweryfikować należy użyć oprogramowania do weryfikacji podpisu</xsl:text>
						<br />
						<span class="element">
							<xsl:text>Lista podpisanych elementów (referencji):</xsl:text>
						</span>
						<br />
						<xsl:for-each select="pos:Dokument/ds:Signature/ds:SignedInfo/ds:Reference">
							<span class="element">
								<xsl:text>referencja </xsl:text>
								<xsl:value-of select="@Id" />
								<xsl:text> : </xsl:text>
							</span>
							<xsl:value-of select="@URI" />
							<br />
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Poświadczenie nie zawiera podpisu </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>