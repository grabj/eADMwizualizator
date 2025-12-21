<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ndap="http://www.mswia.gov.pl/standardy/ndap"
    xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
    exclude-result-prefixes="ndap ds">

	<xsl:output method="html" encoding="UTF-8" indent="yes"/>

	<!-- Główny szablon -->
	<xsl:template match="/">
		<html>
			<head>
				<meta charset="UTF-8"/>
				<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
				<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
				<title>Metadane dokumentu</title>
				<style>
					* {
					box-sizing: border-box;
					}

					body {
					font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
					margin: 0;
					padding: 15px;
					background-color: #f5f5f5;
					line-height: 1.5;
					}

					.container {
					max-width: 100%;
					background-color: white;
					border-radius: 8px;
					box-shadow: 0 2px 8px rgba(0,0,0,0.1);
					padding: 20px;
					word-wrap: break-word;
					overflow-wrap: break-word;
					}

					h3 {
					color: #2c3e50;
					font-weight: 700;
					margin-top: 0;
					margin-bottom: 8px;
					word-wrap: break-word;
					}

					h3.alternative {
					color: #555;
					font-weight: 500;
					margin-top: 5px;
					font-style: italic;
					line-height: 1.4;
					}

					.section {
					margin-bottom: 20px;
					padding-bottom: 15px;
					border-bottom: 1px solid #e0e0e0;
					}

					.section:last-child {
					border-bottom: none;
					}

					.label {
					font-weight: 700;
					color: #34495e;
					margin-bottom: 8px;
					}

					.value {
					color: #555;
					margin-bottom: 10px;
					word-wrap: break-word;
					white-space: pre-wrap;
					}

					.item {
					background-color: #f8f9fa;
					padding: 10px;
					margin-bottom: 10px;
					border-radius: 4px;
					border-left: 3px solid #3498db;
					line-height: 1.4;
					}

					.item:last-child {
					margin-bottom: 0;
					}

					.item-line {
					margin-bottom: 5px;
					}

					.item-line:last-child {
					margin-bottom: 0;
					}

					.sub-item {
					margin-left: 15px;
					margin-top: 5px;
					}

					.advanced {
					margin-top: 30px;
					}

					.collapsible {
					background-color: #3498db;
					color: white;
					cursor: pointer;
					padding: 12px;
					width: 100%;
					border: none;
					text-align: left;
					outline: none;
					border-radius: 4px;
					transition: background-color 0.3s;
					font-weight: 600;
					display: block;
					}

					.collapsible:hover {
					background-color: #2980b9;
					}

					.collapsible:after {
					content: '\25BC';
					float: right;
					margin-left: 5px;
					}

					.collapsible.active:after {
					content: '\25B2';
					}

					.content {
					display: none;
					background-color: #f8f9fa;
					border-radius: 0 0 4px 4px;
					overflow: hidden;
					}

					.content.show {
					display: block;
					}

					.content-inner {
					padding: 15px;
					}

					.address {
					line-height: 1.4;
					}

					strong {
					font-weight: 600;
					}

					@media (max-width: 600px) {
					body {
					padding: 10px;
					}

					.container {
					padding: 15px;
					}
					}
				</style>
			</head>
			<body>
				<div class="container">
					<xsl:apply-templates select="ndap:dokument"/>
				</div>

				<script type="text/javascript">
					function toggleAdvanced(button) {
					var content = button.nextElementSibling;

					if (content) {
					if (content.classList.contains('show')) {
					content.classList.remove('show');
					button.classList.remove('active');
					} else {
					content.classList.add('show');
					button.classList.add('active');
					}
					}
					}
				</script>
			</body>
		</html>
	</xsl:template>

	<!-- Szablon głównego dokumentu -->
	<xsl:template match="ndap:dokument">
		<!-- Tytuł -->
		<xsl:if test="ndap:tytul/ndap:oryginalny">
			<div class="section">
				<div class="label">Tytuł</div>
				<h3>
					<xsl:value-of select="ndap:tytul/ndap:oryginalny"/>
				</h3>
			</div>
		</xsl:if>

		<!-- Tytuł alternatywny -->
		<xsl:if test="ndap:tytul/ndap:alternatywny">
			<div class="section">
				<div class="label">Tytuł alternatywny</div>
				<h3 class="alternative">
					<xsl:value-of select="ndap:tytul/ndap:alternatywny"/>
				</h3>
			</div>
		</xsl:if>

		<!-- Opis -->
		<xsl:if test="ndap:opis and ndap:opis != ''">
			<div class="section">
				<div class="label">Opis</div>
				<div class="value">
					<xsl:value-of select="ndap:opis"/>
				</div>
			</div>
		</xsl:if>

		<!-- Daty -->
		<xsl:if test="ndap:data">
			<div class="section">
				<div class="label">Daty</div>
				<xsl:for-each select="ndap:data">
					<div class="item">
						<xsl:if test="ndap:typ">
							<div class="item-line">
								<strong>Typ:</strong>
								<xsl:text> </xsl:text>
								<xsl:value-of select="ndap:typ"/>
							</div>
						</xsl:if>
						<xsl:if test="ndap:typDaty">
							<div class="item-line">
								<strong>Typ:</strong>
								<xsl:text> </xsl:text>
								<xsl:value-of select="ndap:typDaty"/>
							</div>
						</xsl:if>
						<xsl:if test="ndap:zakresDat">
							<div class="item-line">
								<strong>Zakres:</strong>
								<xsl:text> </xsl:text>
								<xsl:value-of select="ndap:zakresDat"/>
							</div>
						</xsl:if>
						<div class="item-line">
							<strong>Data:</strong>
							<xsl:text> </xsl:text>
							<xsl:choose>
								<xsl:when test="ndap:czas">
									<xsl:call-template name="format-date">
										<xsl:with-param name="date" select="ndap:czas"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="ndap:od or ndap:czasOd">
									<xsl:call-template name="format-date">
										<xsl:with-param name="date" select="ndap:od | ndap:czasOd"/>
									</xsl:call-template>
									<xsl:text> - </xsl:text>
									<xsl:call-template name="format-date">
										<xsl:with-param name="date" select="ndap:do | ndap:czasDo"/>
									</xsl:call-template>
								</xsl:when>
							</xsl:choose>
						</div>
					</div>
				</xsl:for-each>
			</div>
		</xsl:if>

		<!-- Odbiorcy -->
		<xsl:if test="ndap:odbiorca">
			<div class="section">
				<div class="label">Odbiorcy</div>
				<xsl:for-each select="ndap:odbiorca">
					<div class="item">
						<xsl:apply-templates select="ndap:podmiot"/>
						<xsl:if test="ndap:rodzaj">
							<div class="sub-item">
								<xsl:value-of select="ndap:rodzaj"/>
							</div>
						</xsl:if>
						<xsl:if test="ndap:doWiadomosci">
							<div class="sub-item">do wiadomości</div>
						</xsl:if>
					</div>
				</xsl:for-each>
			</div>
		</xsl:if>

		<!-- Twórcy -->
		<xsl:if test="ndap:tworca">
			<div class="section">
				<div class="label">Twórcy</div>
				<xsl:for-each select="ndap:tworca">
					<div class="item">
						<xsl:if test="ndap:funkcja">
							<div class="item-line">
								<strong>Funkcja:</strong>
								<xsl:text> </xsl:text>
								<xsl:value-of select="ndap:funkcja"/>
							</div>
						</xsl:if>
						<xsl:apply-templates select="ndap:podmiot"/>
					</div>
				</xsl:for-each>
			</div>
		</xsl:if>

		<!-- Grupowanie -->
		<xsl:if test="ndap:grupowanie">
			<div class="section">
				<div class="label">Grupowanie</div>
				<xsl:for-each select="ndap:grupowanie">
					<div class="item">
						<xsl:if test="ndap:typ">
							<div class="item-line">
								<strong>Typ:</strong>
								<xsl:text> </xsl:text>
								<xsl:value-of select="ndap:typ"/>
							</div>
						</xsl:if>
						<xsl:if test="ndap:typGrupy">
							<div class="item-line">
								<strong>Typ grupy:</strong>
								<xsl:text> </xsl:text>
								<xsl:value-of select="ndap:typGrupy"/>
							</div>
						</xsl:if>
						<xsl:if test="ndap:kod">
							<div class="item-line">
								<strong>Kod:</strong>
								<xsl:text> </xsl:text>
								<xsl:value-of select="ndap:kod"/>
							</div>
						</xsl:if>
						<xsl:if test="ndap:kodGrupy">
							<div class="item-line">
								<strong>Kod grupy:</strong>
								<xsl:text> </xsl:text>
								<xsl:value-of select="ndap:kodGrupy"/>
							</div>
						</xsl:if>
						<xsl:if test="ndap:opis">
							<div class="item-line">
								<strong>Opis:</strong>
								<xsl:text> </xsl:text>
								<xsl:value-of select="ndap:opis"/>
							</div>
						</xsl:if>
					</div>
				</xsl:for-each>
			</div>
		</xsl:if>

		<!-- Metadane zaawansowane -->
		<div class="advanced">
			<button class="collapsible" onclick="toggleAdvanced(this)">Metadane zaawansowane</button>
			<div class="content">
				<div class="content-inner">

					<!-- Identyfikatory -->
					<xsl:if test="ndap:identyfikator">
						<div class="section">
							<div class="label">Identyfikatory</div>
							<xsl:for-each select="ndap:identyfikator">
								<div class="item">
									<xsl:if test="ndap:typ">
										<div class="item-line">
											<strong>Typ:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:typ"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:typidentyfikatora">
										<div class="item-line">
											<strong>Typ identyfikatora:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:typidentyfikatora"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:wartosc or ndap:wartoscId">
										<div class="item-line">
											<strong>Wartość:</strong>
											<xsl:text> </xsl:text>
											<xsl:choose>
												<xsl:when test="ndap:wartosc">
													<xsl:value-of select="ndap:wartosc"/>
												</xsl:when>
												<xsl:when test="ndap:wartoscId">
													<xsl:value-of select="ndap:wartoscId"/>
												</xsl:when>
											</xsl:choose>
										</div>
									</xsl:if>
									<xsl:if test="ndap:podmiot">
										<div class="item-line">
											<strong>Nadał:</strong>
										</div>
										<div class="sub-item">
											<xsl:apply-templates select="ndap:podmiot"/>
										</div>
									</xsl:if>
								</div>
							</xsl:for-each>
						</div>
					</xsl:if>

					<!-- Nadawca -->
					<xsl:if test="ndap:nadawca">
						<div class="section">
							<div class="label">Nadawca</div>
							<xsl:for-each select="ndap:nadawca">
								<div class="item">
									<xsl:apply-templates select="ndap:podmiot"/>
								</div>
							</xsl:for-each>
						</div>
					</xsl:if>

					<!-- Kwalifikacja -->
					<xsl:if test="ndap:kwalifikacja">
						<div class="section">
							<div class="label">Kwalifikacja</div>
							<xsl:for-each select="ndap:kwalifikacja">
								<div class="item">
									<xsl:if test="ndap:kategoria">
										<div class="item-line">
											<strong>Kategoria:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:kategoria"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:data">
										<div class="item-line">
											<strong>Data nadania:</strong>
											<xsl:text> </xsl:text>
											<xsl:call-template name="format-date">
												<xsl:with-param name="date" select="ndap:data"/>
											</xsl:call-template>
										</div>
									</xsl:if>
									<xsl:if test="ndap:podmiot">
										<div class="item-line">
											<strong>Nadał:</strong>
										</div>
										<div class="sub-item">
											<xsl:apply-templates select="ndap:podmiot"/>
										</div>
									</xsl:if>
								</div>
							</xsl:for-each>
						</div>
					</xsl:if>

					<!-- Relacje -->
					<xsl:if test="ndap:relacja">
						<div class="section">
							<div class="label">Relacje</div>
							<xsl:for-each select="ndap:relacja">
								<div class="item">
									<xsl:if test="ndap:typ">
										<div class="item-line">
											<strong>Typ:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:typ"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:typRelacji">
										<div class="item-line">
											<strong>Typ relacji:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:typRelacji"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:identyfikator">
										<div class="sub-item">
											<xsl:if test="ndap:identyfikator/ndap:typ">
												<div class="item-line">
													<strong>Typ:</strong>
													<xsl:text> </xsl:text>
													<xsl:value-of select="ndap:identyfikator/ndap:typ"/>
												</div>
											</xsl:if>
											<xsl:if test="ndap:identyfikator/ndap:typidentyfikatora">
												<div class="item-line">
													<strong>Typ identyfikatora:</strong>
													<xsl:text> </xsl:text>
													<xsl:value-of select="ndap:identyfikator/ndap:typidentyfikatora"/>
												</div>
											</xsl:if>
											<xsl:if test="ndap:identyfikator/ndap:wartosc or ndap:identyfikator/ndap:wartoscId">
												<div class="item-line">
													<strong>Wartość:</strong>
													<xsl:text> </xsl:text>
													<xsl:choose>
														<xsl:when test="ndap:identyfikator/ndap:wartosc">
															<xsl:value-of select="ndap:identyfikator/ndap:wartosc"/>
														</xsl:when>
														<xsl:when test="ndap:identyfikator/ndap:wartoscId">
															<xsl:value-of select="ndap:identyfikator/ndap:wartoscId"/>
														</xsl:when>
													</xsl:choose>
												</div>
											</xsl:if>
										</div>
									</xsl:if>
								</div>
							</xsl:for-each>
						</div>
					</xsl:if>

					<!-- Status -->
					<xsl:if test="ndap:status">
						<div class="section">
							<div class="label">Status</div>
							<xsl:for-each select="ndap:status">
								<div class="item">
									<xsl:if test="ndap:rodzaj">
										<div class="item-line">
											<strong>Rodzaj:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:rodzaj"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:wersja">
										<div class="item-line">
											<strong>Wersja:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:wersja"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:opis">
										<div class="item-line">
											<strong>Opis:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:opis"/>
										</div>
									</xsl:if>
								</div>
							</xsl:for-each>
						</div>
					</xsl:if>

					<!-- Tematyka -->
					<xsl:if test="ndap:tematyka">
						<div class="section">
							<div class="label">Tematyka</div>
							<xsl:for-each select="ndap:tematyka">
								<div class="item">
									<xsl:if test="ndap:przedmiot">
										<div class="item-line">
											<strong>Przedmiot:</strong>
											<xsl:text> </xsl:text>
											<xsl:for-each select="ndap:przedmiot">
												<xsl:if test="position() &gt; 1">, </xsl:if>
												<xsl:value-of select="."/>
											</xsl:for-each>
										</div>
									</xsl:if>
									<xsl:if test="ndap:osoby">
										<div class="item-line">
											<strong>Osoby:</strong>
											<xsl:text> </xsl:text>
											<xsl:for-each select="ndap:osoby">
												<xsl:if test="position() &gt; 1">, </xsl:if>
												<xsl:value-of select="."/>
											</xsl:for-each>
										</div>
									</xsl:if>
									<xsl:if test="ndap:miejsce">
										<div class="item-line">
											<strong>Miejsce:</strong>
											<xsl:text> </xsl:text>
											<xsl:for-each select="ndap:miejsce">
												<xsl:if test="position() &gt; 1">, </xsl:if>
												<xsl:value-of select="."/>
											</xsl:for-each>
										</div>
									</xsl:if>
								</div>
							</xsl:for-each>
						</div>
					</xsl:if>

					<!-- Uprawnienia -->
					<xsl:if test="ndap:uprawnienia">
						<div class="section">
							<div class="label">Uprawnienia</div>
							<div class="value">
								<xsl:value-of select="ndap:uprawnienia"/>
							</div>
						</div>
					</xsl:if>
									
					<!-- Dostęp -->
					<xsl:if test="ndap:dostep">
						<div class="section">
							<div class="label">Dostęp</div>
							<xsl:for-each select="ndap:dostep">
								<div class="item">
									<xsl:if test="ndap:dostepnosc">
										<div class="item-line">
											<strong>Dostępność:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:dostepnosc"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:uwagi">
										<div class="item-line">
											<strong>Uwagi:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:uwagi"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:data">
										<div class="item-line">
											<strong>
												<xsl:value-of select="ndap:data/ndap:typ"/>:
											</strong>
											<xsl:text> </xsl:text>
											<xsl:call-template name="format-date">
												<xsl:with-param name="date" select="ndap:data/ndap:czas"/>
											</xsl:call-template>
										</div>
									</xsl:if>
								</div>
							</xsl:for-each>
						</div>
					</xsl:if>
					
					<!-- Typ -->
					<xsl:if test="ndap:typ">
						<div class="section">
							<div class="label">Typ dokumentu</div>
							<xsl:for-each select="ndap:typ">
								<div class="item">
									<xsl:if test="ndap:kategoria">
										<div class="item-line">
											<strong>Kategoria:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:kategoria"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:rodzaj">
										<div class="item-line">
											<strong>Rodzaj:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:rodzaj"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:klasa">
										<div class="item-line">
											<strong>Klasa:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:klasa"/>
										</div>
									</xsl:if>
								</div>
							</xsl:for-each>
						</div>
					</xsl:if>
					
					<!-- Format -->
					<xsl:if test="ndap:format">
						<div class="section">
							<div class="label">Format</div>
							<xsl:for-each select="ndap:format">
								<div class="item">
									<xsl:if test="ndap:typ">
										<div class="item-line">
											<strong>Typ:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:typ"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:typFormatu">
										<div class="item-line">
											<strong>Typ formatu:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:typFormatu"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:specyfikacja">
										<div class="item-line">
											<strong>Specyfikacja:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:specyfikacja"/>
										</div>
									</xsl:if>
									<xsl:if test="ndap:wielkosc">
										<div class="item-line">
											<strong>Wielkość:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:wielkosc"/>
											<xsl:text> </xsl:text>
											<xsl:choose>
												<xsl:when test="ndap:wielkosc/@jednostka">
													<xsl:value-of select="ndap:wielkosc/@jednostka"/>
												</xsl:when>
												<xsl:when test="ndap:wielkosc/@miara">
													<xsl:value-of select="ndap:wielkosc/@miara"/>
												</xsl:when>
											</xsl:choose>
										</div>
									</xsl:if>
									<xsl:if test="ndap:niekompletnosc">
										<div class="item-line">
											<strong>Niekompletność:</strong>
											<xsl:text> </xsl:text>
											<xsl:value-of select="ndap:niekompletnosc"/>
										</div>
									</xsl:if>
								</div>
							</xsl:for-each>
						</div>
					</xsl:if>

					<!-- Język -->
					<xsl:if test="ndap:jezyk">
						<div class="section">
							<div class="label">Język</div>
							<div class="value"><xsl:for-each select="ndap:jezyk"><xsl:if test="position() &gt; 1"><xsl:text>, </xsl:text></xsl:if><xsl:choose><xsl:when test=". != ''"><xsl:value-of select="."/></xsl:when><xsl:otherwise><xsl:choose><xsl:when test="@kod"><xsl:value-of select="@kod"/></xsl:when><xsl:when test="@kodJezyka"><xsl:value-of select="@kodJezyka"/></xsl:when></xsl:choose></xsl:otherwise></xsl:choose></xsl:for-each></div>
						</div>
					</xsl:if>


				</div>
			</div>
		</div>
	</xsl:template>

	<!-- Szablon dla podmiotu -->
	<xsl:template match="ndap:podmiot">
		<xsl:choose>
			<xsl:when test="ndap:osoba">
				<xsl:apply-templates select="ndap:osoba"/>
			</xsl:when>
			<xsl:when test="ndap:instytucja">
				<xsl:apply-templates select="ndap:instytucja"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- Szablon dla osoby -->
	<xsl:template match="ndap:osoba">
		<div>
			<xsl:if test="ndap:imie">
				<xsl:value-of select="ndap:imie"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:if test="ndap:nazwisko">
				<strong>
					<xsl:value-of select="ndap:nazwisko"/>
				</strong>
			</xsl:if>
		</div>
		<xsl:if test="ndap:id">
			<div class="sub-item">
				<xsl:for-each select="ndap:id">
					<div class="item-line">
						<strong><xsl:value-of select="@typ"/>:</strong>
						<xsl:text> </xsl:text>
						<xsl:value-of select="."/>
					</div>
				</xsl:for-each>
			</div>
		</xsl:if>
		<xsl:if test="ndap:adres">
			<xsl:apply-templates select="ndap:adres"/>
		</xsl:if>
		<xsl:if test="ndap:kontakt">
			<div class="sub-item">
				<xsl:for-each select="ndap:kontakt">
					<div class="item-line">
						<strong><xsl:choose>
							<xsl:when test="@typ">
								<xsl:value-of select="@typ"/>
							</xsl:when>
							<xsl:when test="@typKontaktu">
								<xsl:value-of select="@typKontaktu"/>
							</xsl:when>
						</xsl:choose>:</strong>
						<xsl:text> </xsl:text>
						<xsl:value-of select="."/>
					</div>
				</xsl:for-each>
			</div>
		</xsl:if>
	</xsl:template>

	<!-- Szablon dla instytucji -->
	<xsl:template match="ndap:instytucja">
		<div>
			<strong>
				<xsl:value-of select="ndap:nazwa"/>
			</strong>
		</div>
		<xsl:if test="ndap:id">
			<div class="sub-item">
				<xsl:for-each select="ndap:id">
					<div class="item-line">
						<strong><xsl:choose>
							<xsl:when test="@typ">
								<xsl:value-of select="@typ"/>
							</xsl:when>
							<xsl:when test="@typId">
								<xsl:value-of select="@typId"/>
							</xsl:when>
						</xsl:choose>:</strong>
						<xsl:text> </xsl:text>
						<xsl:value-of select="."/>
					</div>
				</xsl:for-each>
			</div>
		</xsl:if>
		<xsl:if test="ndap:jednostka">
			<div class="sub-item">
				<xsl:apply-templates select="ndap:jednostka"/>
			</div>
		</xsl:if>
		<xsl:if test="ndap:adres">
			<xsl:apply-templates select="ndap:adres"/>
		</xsl:if>
		<xsl:if test="ndap:kontakt">
			<div class="sub-item">
				<xsl:for-each select="ndap:kontakt">
					<div class="item-line">
						<strong><xsl:choose>
							<xsl:when test="@typ">
								<xsl:value-of select="@typ"/>
							</xsl:when>
							<xsl:when test="@typKontaktu">
								<xsl:value-of select="@typKontaktu"/>
							</xsl:when>
						</xsl:choose>:</strong>
						<xsl:text> </xsl:text>
						<xsl:value-of select="."/>
					</div>
				</xsl:for-each>
			</div>
		</xsl:if>
		<xsl:if test="ndap:pracownik">
			<div class="sub-item">
				<xsl:apply-templates select="ndap:pracownik"/>
			</div>
		</xsl:if>
	</xsl:template>

	<!-- Szablon dla jednostki -->
	<xsl:template match="ndap:jednostka">
		<div>
			<em>
				Jednostka: <xsl:value-of select="ndap:nazwa"/>
			</em>
		</div>
		<xsl:if test="ndap:pracownik">
			<xsl:apply-templates select="ndap:pracownik"/>
		</xsl:if>
		<xsl:if test="ndap:jednostka">
			<div style="margin-left: 15px;">
				<xsl:apply-templates select="ndap:jednostka"/>
			</div>
		</xsl:if>
	</xsl:template>

	<!-- Szablon dla pracownika -->
	<xsl:template match="ndap:pracownik">
		<div style="margin-top: 5px;">
			<xsl:if test="ndap:imie">
				<xsl:value-of select="ndap:imie"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:if test="ndap:nazwisko">
				<xsl:value-of select="ndap:nazwisko"/>
			</xsl:if>
			<xsl:if test="ndap:funkcja">
				<xsl:text> (</xsl:text>
				<xsl:value-of select="ndap:funkcja"/>
				<xsl:text>)</xsl:text>
			</xsl:if>
			<xsl:if test="ndap:stanowisko">
				<xsl:text> - </xsl:text>
				<xsl:value-of select="ndap:stanowisko"/>
			</xsl:if>
		</div>
	</xsl:template>

	<!-- Szablon dla komórki -->
	<xsl:template match="ndap:komorka">
		<div style="margin-left: 15px; margin-top: 5px;">
			<em>
				Komórka: <xsl:value-of select="ndap:nazwa"/>
			</em>
			<xsl:if test="ndap:pracownik">
				<xsl:apply-templates select="ndap:pracownik"/>
			</xsl:if>
			<xsl:if test="ndap:komorka">
				<xsl:apply-templates select="ndap:komorka"/>
			</xsl:if>
		</div>
	</xsl:template>

	<!-- Szablon dla adresu -->
	<xsl:template match="ndap:adres">
		<div class="sub-item address">
			<xsl:if test="ndap:ulica or ndap:budynek or ndap:lokal">
				<div>
					<xsl:if test="ndap:ulica">
						<xsl:value-of select="ndap:ulica"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:if test="ndap:budynek">
						<xsl:value-of select="ndap:budynek"/>
					</xsl:if>
					<xsl:if test="ndap:lokal">
						<xsl:text>/</xsl:text>
						<xsl:value-of select="ndap:lokal"/>
					</xsl:if>
				</div>
			</xsl:if>
			<xsl:if test="ndap:kod or ndap:miejscowosc or ndap:kodPocztowy">
				<div>
					<xsl:choose>
						<xsl:when test="ndap:kodPocztowy">
							<xsl:value-of select="ndap:kodPocztowy"/>
						</xsl:when>
						<xsl:when test="ndap:kod">
							<xsl:value-of select="ndap:kod"/>
						</xsl:when>
					</xsl:choose>
					<xsl:if test="ndap:miejscowosc">
						<xsl:text> </xsl:text>
						<xsl:value-of select="ndap:miejscowosc"/>
					</xsl:if>
				</div>
			</xsl:if>
			<xsl:if test="ndap:kraj">
				<div>
					<xsl:value-of select="ndap:kraj"/>
				</div>
			</xsl:if>
		</div>
	</xsl:template>

	<!-- Szablon formatowania daty -->
	<xsl:template name="format-date">
		<xsl:param name="date"/>
		<xsl:choose>
			<!-- Pełna data z czasem: 2020-09-09T00:00:00+02:00 -->
			<xsl:when test="contains($date, 'T')">
				<xsl:variable name="datepart" select="substring-before($date, 'T')"/>
				<xsl:variable name="timepart" select="substring-after($date, 'T')"/>
				<xsl:variable name="year" select="substring($datepart, 1, 4)"/>
				<xsl:variable name="month" select="substring($datepart, 6, 2)"/>
				<xsl:variable name="day" select="substring($datepart, 9, 2)"/>
				<xsl:variable name="hour" select="substring($timepart, 1, 2)"/>
				<xsl:variable name="minute" select="substring($timepart, 4, 2)"/>

				<xsl:value-of select="$day"/>.<xsl:value-of select="$month"/>.<xsl:value-of select="$year"/>

				<!-- Wyświetl godzinę tylko jeśli nie jest 00:00 -->
				<xsl:if test="$hour != '00' or $minute != '00'">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$hour"/>:<xsl:value-of select="$minute"/>
				</xsl:if>
			</xsl:when>
			<!-- Pełna data bez czasu: 2020-09-09 -->
			<xsl:when test="string-length($date) = 10 and contains($date, '-')">
				<xsl:variable name="year" select="substring($date, 1, 4)"/>
				<xsl:variable name="month" select="substring($date, 6, 2)"/>
				<xsl:variable name="day" select="substring($date, 9, 2)"/>
				<xsl:value-of select="$day"/>.<xsl:value-of select="$month"/>.<xsl:value-of select="$year"/>
			</xsl:when>
			<!-- Rok i miesiąc: 2020-09 -->
			<xsl:when test="string-length($date) = 7 and contains($date, '-')">
				<xsl:variable name="year" select="substring($date, 1, 4)"/>
				<xsl:variable name="month" select="substring($date, 6, 2)"/>
				<xsl:value-of select="$month"/>.<xsl:value-of select="$year"/>
			</xsl:when>
			<!-- Tylko rok: 2020 -->
			<xsl:when test="string-length($date) = 4">
				<xsl:value-of select="$date"/>
			</xsl:when>
			<!-- Pusta data -->
			<xsl:when test="$date = ''">
				<xsl:text>brak</xsl:text>
			</xsl:when>
			<!-- Nieznany format -->
			<xsl:otherwise>
				<xsl:value-of select="$date"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>