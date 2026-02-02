<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns1="http://www.finn.pl/schema/fsawpe">

	<xsl:output method="html" omit-xml-declaration="yes" encoding="UTF-8"/>

	<xsl:template match="/">
		<html>
			<head>
				<meta charset="utf-8"/>
				<title>Weryfikacja podpisu</title>

				<style type="text/css">
					* { margin: 0; padding: 0; }
					img { border: 0; }
					body { font: normal 14px Arial; color: #000; text-align: center; background-color: #f5f5f5; }

					#container {
					width: 800px;
					margin: 20px auto;
					padding: 10px;
					text-align: left;
					background-color: whitesmoke;
					}

					.signature-item {
					background-color: white;
					border: 1px solid #c0c0c0;
					padding: 15px;
					margin-bottom: 20px;
					border-radius: 4px;
					}

					.signature-header {
					background-color: #bed6f8;
					padding: 10px;
					margin: -15px -15px 15px -15px;
					border-bottom: 1px solid #c0c0c0;
					border-radius: 3px 3px 0 0;
					}

					.signature-header h2 {
					margin: 0;
					font-size: 16px;
					color: #000;
					}

					.signature-status {
					display: inline-block;
					padding: 5px 10px;
					border-radius: 3px;
					font-weight: bold;
					margin-bottom: 5px;
					}

					.status-valid {
					background-color: #d4edda;
					color: #155724;
					}

					.status-invalid {
					background-color: #f8d7da;
					color: #721c24;
					}

					.status-probable {
					background-color: #fff3cd;
					color: #856404;
					}

					table {
					border: 1px solid #c0c0c0;
					width: 100%;
					margin-bottom: 15px;
					border-collapse: collapse;
					}

					table tr td {
					padding: 8px;
					border: 1px solid #c0c0c0;
					font-size: 12px;
					}

					table tr td:first-child {
					font-weight: bold;
					width: 40%;
					background-color: #f8f9fa;
					}

					table tr th {
					padding: 8px;
					border: 1px solid #c0c0c0;
					font-size: 14px;
					background-color: #bed6f8;
					text-align: left;
					}

					h3 {
					margin: 15px 0 10px 0;
					font-size: 13px;
					color: #555;
					}

					p {
					margin-bottom: 8px;
					line-height: 1.4;
					}

					.info-text {
					color: #666;
					font-size: 13px;
					}

					.file-list {
					background-color: #f8f9fa;
					padding: 10px;
					border-left: 3px solid #bed6f8;
					margin-top: 10px;
					}

					.file-list b {
					display: block;
					margin-bottom: 5px;
					}

					.no-reports {
					background-color: white;
					border: 1px solid #c0c0c0;
					padding: 20px;
					text-align: center;
					}
				</style>
			</head>

			<body>
				<div id="container">
					<xsl:choose>
						<xsl:when test="//ns1:raport">
							<!-- Lista podpisów jeden pod drugim -->
							<xsl:for-each select="//ns1:raport">
								<div class="signature-item">
									<div class="signature-header">
										<h2>
											<xsl:value-of select="child::ns1:tytul"/>
										</h2>
									</div>

									<!-- Status podpisu -->
									<div>
										<xsl:choose>
											<xsl:when test="child::ns1:status = '1'">
												<span class="signature-status status-valid">
													<xsl:choose>
														<xsl:when test="child::ns1:pz = 'tak'">
															✓ Podpis prawidłowy Profilem Zaufanym ePUAP
														</xsl:when>
														<xsl:otherwise>
															✓ Podpis prawidłowy
														</xsl:otherwise>
													</xsl:choose>
												</span>
											</xsl:when>
											<xsl:when test="child::ns1:status = '0'">
												<span class="signature-status status-invalid">
													✗ Podpis nieprawidłowy
												</span>
											</xsl:when>
											<xsl:when test="child::ns1:status = '2'">
												<span class="signature-status status-probable">
													⚠ Podpis prawdopodobnie prawidłowy
												</span>
											</xsl:when>
										</xsl:choose>
									</div>

									<!-- Dodatkowe informacje -->
									<xsl:if test="child::ns1:kw or child::ns1:opis/ns1:zdanie or child::ns1:epuap = 'tak'">
										<h3>Szczegóły:</h3>
										<div class="info-text">
											<xsl:for-each select="child::ns1:kw">
												<p>
													<xsl:value-of select="."/>
												</p>
											</xsl:for-each>
											<xsl:for-each select="child::ns1:opis/ns1:zdanie">
												<p>
													<xsl:value-of select="."/>
												</p>
											</xsl:for-each>
											<xsl:if test="child::ns1:epuap = 'tak'">
												<p>
													<strong>Wynik weryfikacji podpisu potwierdzony przez ePUAP</strong>
												</p>
											</xsl:if>
										</div>
									</xsl:if>

									<!-- Data i czas -->
									<p style="margin-top: 15px;">
										<strong>Data i czas złożenia podpisu:</strong>
										<xsl:text> </xsl:text>
										<xsl:value-of select="child::ns1:data"/>
									</p>

									<xsl:if test="child::ns1:statusTS = '1'">
										<p>
											<strong>Data i czas potwierdzonego znacznika czasu:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="child::ns1:dataTS"/>
										</p>
									</xsl:if>
									<xsl:if test="child::ns1:statusTS = '2'">
										<p style="color: #dc3545;">
											<strong>Uwaga:</strong> Podpis zawiera znacznik czasu, który nie mógł zostać potwierdzony!
										</p>
									</xsl:if>

									<!-- Tabela: PODPISUJĄCY -->
									<table>
										<tr>
											<th colspan="2">PODPISUJĄCY</th>
										</tr>
										<xsl:for-each select="child::ns1:podpisujacy/ns1:pole">
											<tr>
												<td>
													<xsl:value-of select="@nazwa"/>
												</td>
												<td>
													<xsl:value-of select="."/>
												</td>
											</tr>
										</xsl:for-each>

										<xsl:if test="child::ns1:pz = 'nie'">
											<xsl:for-each select="child::ns1:certyfikat/ns1:pole">
												<tr>
													<td>
														<xsl:value-of select="@nazwa"/>
													</td>
													<td>
														<xsl:value-of select="."/>
													</td>
												</tr>
											</xsl:for-each>
										</xsl:if>

										<xsl:if test="child::ns1:pz = 'tak'">
											<tr>
												<td colspan="2" style="background-color: #e7f3ff;">
													Podpisano przy użyciu Profilu Zaufanego ePUAP
												</td>
											</tr>
										</xsl:if>
									</table>

									<!-- Tabela: PODPISUJĄCY W SYSTEMIE EZD FINN -->
									<xsl:if test="ns1:ezdFinnRole">
										<table>
											<tr>
												<th colspan="2">PODPISUJĄCY W SYSTEMIE EZD FINN</th>
											</tr>
											<xsl:for-each select="child::ns1:ezdFinnRole/ns1:pole">
												<xsl:if test="contains('Imię i nazwisko|Komórka|Dokument|Nazwa organizacji', @nazwa)">
													<tr>
														<td>
															<xsl:value-of select="@nazwa"/>
														</td>
														<td>
															<xsl:value-of select="."/>
														</td>
													</tr>
												</xsl:if>
											</xsl:for-each>
										</table>
									</xsl:if>

									<!-- Tabela: WYSTAWCA CERTYFIKATU -->
									<table>
										<tr>
											<th colspan="2">WYSTAWCA CERTYFIKATU</th>
										</tr>
										<xsl:for-each select="child::ns1:wystawca/ns1:pole">
											<tr>
												<td>
													<xsl:value-of select="@nazwa"/>
												</td>
												<td>
													<xsl:value-of select="."/>
												</td>
											</tr>
										</xsl:for-each>
									</table>

									<!-- Lista plików -->
									<xsl:if test="child::ns1:pliki/ns1:plik">
										<div class="file-list">
											<strong>Lista plików podpisanych elektronicznie powyższym podpisem:</strong>
											<xsl:for-each select="child::ns1:pliki/ns1:plik">
												<b>
													<xsl:value-of select="."/>
												</b>
											</xsl:for-each>
										</div>
									</xsl:if>
								</div>
							</xsl:for-each>

							<!-- Dodatkowa lista wszystkich plików (jeśli istnieje) -->
							<xsl:if test="count(/ns1:sawpe/ns1:pliki/ns1:plik) &gt; 0">
								<div class="signature-item">
									<div class="signature-header">
										<h2>Lista wszystkich plików</h2>
									</div>
									<div class="file-list">
										<xsl:for-each select="/ns1:sawpe/ns1:pliki/ns1:plik">
											<b>
												<xsl:value-of select="."/>
											</b>
										</xsl:for-each>
									</div>
								</div>
							</xsl:if>
						</xsl:when>

						<xsl:otherwise>
							<div class="no-reports">
								<h2>Brak danych do wyświetlenia</h2>
								<p>
									Upewnij się, że plik XML zawiera elementy w przestrzeni nazw <code>http://www.finn.pl/schema/fsawpe</code>.
								</p>
							</div>
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>