<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0" xmlns:zn="http://pue.zus.pl/rd/ZN/2/"
	xmlns:adr="http://pue.zus.pl/rd/ZN/2/" 
	xmlns:oso="http://pue.zus.pl/rd/ZN/2/"
	xmlns:str="http://pue.zus.pl/rd/ZN/2/"
	xmlns:meta="http://pue.zus.pl/rd/ZN/2/"
	xmlns:inst="http://pue.zus.pl/rd/ZN/2/"
	xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
	<xsl:template match="/">
	<!-- Styl do dok. ZN 
	26-10-2022 poprawiono składanie danych adresowych oraz dodano słowo - wymagalnych w treści dok. 
	-->
	
		<html>
			<head>
				<meta http-equiv="pragma" content="no-cache" />
				<style>
					<xsl:text>
        .id-left { font-weight: bold; padding-right: 1em; }
        .id-right { padding-right: 1em; font-family: monospace; }
        .referent { font-weight: bold; }
        .head-zus { align: left; }
        .head-data { align: right; }
        h2 { text-align: center; font-weight: bolder; }
        </xsl:text>
				</style>
				<title>
					<xsl:value-of
						select="//zn:Dokument/zn:DaneDokumentu/str:Naglowek/str:NazwaDokumentu" />
				</title>
			</head>
			<body>

      	<xsl:element name="table">
      		<xsl:attribute name="width">100%</xsl:attribute>
      		<xsl:element name="tr">
      			<xsl:element name="td">
      				<xsl:attribute name="class">head-zus</xsl:attribute>
                <xsl:value-of select="//zn:Dokument/zn:DaneDokumentu/str:Nadawcy/meta:Podmiot/inst:Instytucja/inst:NazwaInstytucji"/><br/> 
					
                     ul. 
					<xsl:value-of select="//zn:Dokument/zn:DaneDokumentu/str:Nadawcy/meta:Podmiot/inst:Instytucja/adr:Adres/adr:Ulica"/><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
					<xsl:value-of select="//zn:Dokument/zn:DaneDokumentu/str:Nadawcy/meta:Podmiot/inst:Instytucja/adr:Adres/adr:Budynek"/>
					<xsl:if test="//zn:Dokument/zn:DaneDokumentu/str:Nadawcy/meta:Podmiot/inst:Instytucja/adr:Adres/adr:Lokal != ''">/
					<xsl:value-of select="//zn:Dokument/zn:DaneDokumentu/str:Nadawcy/meta:Podmiot/inst:Instytucja/adr:Adres/adr:Lokal"/>
					</xsl:if><br/>
					<xsl:variable name = "INST_kodp">
						<xsl:variable name = "kodp_inst" select = "//zn:Dokument/zn:DaneDokumentu/str:Nadawcy/meta:Podmiot/inst:Instytucja/adr:Adres/adr:KodPocztowy"/>					
							  <xsl:choose>
								<xsl:when test="substring($kodp_inst,3,1)='-'">
								 <xsl:value-of select = "$kodp_inst"/>
								</xsl:when>
								<xsl:otherwise>
								 <xsl:value-of select = "substring($kodp_inst, 1, 2)"/>-<xsl:value-of select = "substring($kodp_inst, 3, 3)"/>
								</xsl:otherwise>
							  </xsl:choose>					  					  
						</xsl:variable>
					<xsl:value-of select="$INST_kodp"/><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
					<xsl:value-of select="//zn:Dokument/zn:DaneDokumentu/str:Nadawcy/meta:Podmiot/inst:Instytucja/adr:Adres/adr:Miejscowosc"/>					
					
      			</xsl:element>
      			<xsl:element name="td">
      				<xsl:attribute name="class">head-data</xsl:attribute>
                Data wydania: <xsl:value-of select="//zn:Dokument/zn:DaneDokumentu/meta:Data/meta:Czas"/>                
      			</xsl:element>
      		</xsl:element>
      	</xsl:element>

				<h2><xsl:value-of select="//zn:Dokument/zn:DaneDokumentu/str:Naglowek/str:NazwaDokumentu" /></h2>

				<ol>
					<li>
						Nr zaświadczenia:<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
						<xsl:value-of
							select="//zn:Dokument/zn:DaneDokumentu/str:Naglowek/meta:Identyfikator[@typIdentyfikatora='nr_zaswiadczenia']/meta:Wartosc" />
					</li>
					<li>
						Dane wnioskodawcy (płatnika składek):
						<br />
						Nazwa / Nazwisko i imię / Adres:<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
						<xsl:value-of select="//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/inst:Instytucja/inst:NazwaInstytucji" /> /<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text><xsl:value-of select="//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/oso:Osoba/oso:Nazwisko" /> 
						<xsl:value-of select="//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/oso:Osoba/oso:Imie" /> /<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
						<xsl:call-template name="adres"/>
					</li>


					<xsl:element name="table">
						<xsl:element name="tr">
							<xsl:element name="td">
								<xsl:attribute name="class">id-left</xsl:attribute>
								NIP
							</xsl:element>
							<xsl:element name="td">
								<xsl:attribute name="class">id-right</xsl:attribute>
								<xsl:value-of
									select="//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/inst:Instytucja/inst:IdInstytucji/inst:NIP" />
								<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
							</xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="td">
								<xsl:attribute name="class">id-left</xsl:attribute>
								REGON
							</xsl:element>
							<xsl:element name="td">
								<xsl:attribute name="class">id-right</xsl:attribute>
								<xsl:value-of
									select="//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/inst:Instytucja/inst:IdInstytucji/inst:REGON" />
								<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
							</xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="td">
								<xsl:attribute name="class">id-left</xsl:attribute>
								PESEL
							</xsl:element>
							<xsl:element name="td">
								<xsl:attribute name="class">id-right</xsl:attribute>
								<xsl:value-of
									select="//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/oso:Osoba/oso:IdOsoby/oso:PESEL" />
								<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
							</xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="td">
								<xsl:attribute name="class">id-left</xsl:attribute>
								Seria i nr dokumentu tożsamości
							</xsl:element>
							<xsl:element name="td">
								<xsl:attribute name="class">id-right</xsl:attribute>
								<xsl:value-of
									select="//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/oso:Osoba/oso:IdOsoby/oso:InnyIdentyfikator/oso:WartoscIdentyfikatora" />
								<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
							</xsl:element>
						</xsl:element>
					</xsl:element>

					<li>
						<xsl:element name="p">
							<xsl:choose>
								<xsl:when
									test="string(//zn:TrescDokumentu/zn:Zobowiazania/meta:Data/meta:Do) != ''"><!-- były płatnik składek -->
									<xsl:choose>
										<xsl:when
											test="string(//zn:TrescDokumentu/zn:Zawieszenie/meta:Data/meta:Od) != ''"><!-- zawieszenie zobowiązań -->
											Zaświadcza się, że wnioskodawca w dniu wydania zaświadczenia
											korzysta od dnia
											<xsl:value-of
												select="//zn:TrescDokumentu/zn:Zawieszenie/meta:Data/meta:Od" />
											z prawa do zawieszenia działalności gospodarczej. Z tytułu
											istniejącego do dnia
											<xsl:value-of
												select="//zn:TrescDokumentu/zn:Zobowiazania/meta:Data/meta:Do" />
											obowiązku opłacania składek na:
										</xsl:when>
										<xsl:otherwise><!-- bieżące zobowiązania (brak zawieszenia) -->
											Zaświadcza się, że wnioskodawca w dniu wydania zaświadczenia
											nie jest płatnikiem składek, natomiast z tytułu istniejącego
											do dnia
											<xsl:value-of
												select="//zn:TrescDokumentu/zn:Zobowiazania/meta:Data/meta:Do" />
											obowiązku opłacania składek na:
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise><!-- aktualny płatnik składek -->
									Zaświadcza się, że wnioskodawca (płatnik składek) zobowiązany
									jest do opłacania składek na:
								</xsl:otherwise>
							</xsl:choose>

							<xsl:element name="ol">
								<xsl:attribute name="type">a</xsl:attribute>
								<xsl:for-each
									select="//zn:TrescDokumentu/zn:Zobowiazania/zn:Zobowiazanie">
									<xsl:element name="li">
										<xsl:value-of select="." />
									</xsl:element>
								</xsl:for-each>
							</xsl:element>
						</xsl:element>
						<xsl:element name="p">
							nie posiada zaległości wymagalnych według stanu na dzień
							<xsl:value-of
								select="//zn:TrescDokumentu//zn:StanRozliczen/meta:Data/meta:Czas" />
						</xsl:element>
						<xsl:if test="//zn:TrescDokumentu/zn:Ulgi/zn:Ulga">
							<xsl:element name="p">
								gdyż korzysta z ulgi w postaci:
								<xsl:element name="ul">
									<xsl:for-each select="//zn:TrescDokumentu/zn:Ulgi/zn:Ulga">
										<xsl:element name="li">
											<xsl:value-of select="." />
										</xsl:element>
									</xsl:for-each>
								</xsl:element>
							</xsl:element>
						</xsl:if>
					</li>
				</ol>

				<xsl:element name="p">
					Zaświadczenie wydaje się na wniosek płatnika składek, na podstawie
					<xsl:value-of select="//zn:TrescDokumentu/zn:PodstawaPrawna" />
				</xsl:element>
				<xsl:element name="p">
					<xsl:attribute name="class">referent</xsl:attribute>
					Pracownik ZUS upoważniony do wydania zaświadczenia: <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
					<xsl:value-of
						select="concat(//str:Nadawcy/meta:Podmiot/inst:Instytucja/inst:Pracownik/oso:Imie, ' ', //str:Nadawcy/meta:Podmiot/inst:Instytucja/inst:Pracownik/oso:Nazwisko)" />
				</xsl:element>
				<br />
				<xsl:call-template name="signature" />
			</body>
		</html>

	</xsl:template>
	
<xsl:template name="adres">

	<xsl:variable name = "PLA_miejsc" select = "//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/oso:Osoba/adr:Adres/adr:Miejscowosc"/>
	<xsl:variable name = "PLA_poczta" select = "//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/oso:Osoba/adr:Adres/adr:Poczta"/>
	<xsl:variable name = "PLA_ulica"><xsl:value-of select = "//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/oso:Osoba/adr:Adres/adr:Ulica"/></xsl:variable>
	<xsl:variable name = "PLA_kodp">
	<xsl:variable name = "kodp" select = "//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/oso:Osoba/adr:Adres/adr:KodPocztowy"/>
			
			 <xsl:choose>
					<xsl:when test="substring($kodp,3,1)='-'">
					 <xsl:value-of select = "$kodp"/>
					</xsl:when>
					<xsl:otherwise>
					 <xsl:value-of select = "substring($kodp, 1, 2)"/>-<xsl:value-of select = "substring($kodp, 3, 3)"/>
					</xsl:otherwise>
			</xsl:choose>
						
	</xsl:variable>
	<xsl:variable name = "PLA_nrdomu" select = "//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/oso:Osoba/adr:Adres/adr:Budynek"/>
	<xsl:variable name = "PLA_nrlokalu" select = "//zn:Dokument/zn:DaneDokumentu/str:Adresaci/meta:Podmiot/oso:Osoba/adr:Adres/adr:Lokal"/>
		
	<xsl:variable name = "czlon_numer_domu_lokalu">
				<xsl:value-of select = "$PLA_nrdomu"/>
				<xsl:if test = "$PLA_nrlokalu != ''">
				<xsl:value-of select = "concat('/', $PLA_nrlokalu)"/>
				</xsl:if>
	</xsl:variable>
				
	<xsl:variable name = "czlon_kod_pocztowy">	
		<xsl:choose>
			<xsl:when test = "$PLA_poczta != ''">
				<xsl:value-of select = "concat($PLA_kodp, concat(' ', $PLA_poczta))"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select = "concat($PLA_kodp, concat(' ', $PLA_miejsc))"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
		
	<xsl:variable name = "czlon_Adres">	
		
		<!-- 	<xsl:value-of select = "concat($ulica_miejscowosc, concat(' ', $czlon_numer_domu_lokalu))"/>	-->						
		<xsl:variable name = "ulica_miejscowosc">
			<xsl:choose>
				<xsl:when test = "($PLA_ulica != '')">
				<xsl:value-of select = "concat('ul. ', $PLA_ulica)"/>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
		    <!-- miejscowosc jest, poczta jest, miejscowosc != poczta, ulica jest  -->
			<xsl:when test = "($PLA_poczta != '') and ($PLA_miejsc != $PLA_poczta) and ($PLA_ulica != '')">
				<xsl:value-of select = "concat($ulica_miejscowosc, concat(' ', concat($czlon_numer_domu_lokalu, concat(' ', $PLA_miejsc))))"/>
			</xsl:when>
			<!-- miejscowosc jest, poczta jest, miejscowosc != poczta, ulica pusta  -->
			<xsl:when test = "($PLA_poczta != '') and ($PLA_miejsc != $PLA_poczta) and ($PLA_ulica = '')">
				<xsl:value-of select = "concat($PLA_miejsc, concat(' ', $czlon_numer_domu_lokalu))"/>
			</xsl:when>	
			<!-- miejscowosc jest, poczta pusta, ulica pusta  -->
			<xsl:when test = "($PLA_poczta = '') and ($PLA_miejsc != '')  and ($PLA_ulica = '')">
				<!--  <xsl:value-of select = "concat($PLA_miejsc, concat(' ',$czlon_numer_domu_lokalu))"/>-->
				<xsl:value-of select = "$czlon_numer_domu_lokalu"/>				
			</xsl:when>
			<!-- miejscowosc jest, poczta pusta, ulica jest  -->
			<xsl:when test = "($PLA_poczta = '') and ($PLA_miejsc != '') and ($PLA_ulica != '')">
				<xsl:value-of select = "concat($ulica_miejscowosc, concat(' ', $czlon_numer_domu_lokalu))"/>
			</xsl:when>	
			<!-- miejscowosc jest, poczta jest, miejscowosc = poczta, ulica jest  -->
			<xsl:when test = "($PLA_poczta = $PLA_miejsc) and ($ulica_miejscowosc != '')">
				<xsl:value-of select = "concat($ulica_miejscowosc, concat(' ', $czlon_numer_domu_lokalu))"/>
			</xsl:when>
			<!-- miejscowosc jest, poczta jest, miejscowosc = poczta, ulica pusta  -->
			<xsl:when test = "($PLA_poczta = $PLA_miejsc) and ($ulica_miejscowosc = '')"></xsl:when>			
		</xsl:choose>				
								
	</xsl:variable>
						
	<xsl:if test = "$czlon_Adres != ''"><xsl:value-of select = "$czlon_Adres"/><xsl:value-of select="concat('',' ')"/></xsl:if>
	
	<xsl:value-of select = "$czlon_kod_pocztowy"/> 
	
	<xsl:if test = "$czlon_Adres = ''"> <xsl:value-of select = "$czlon_numer_domu_lokalu"/></xsl:if>

</xsl:template>


	<xsl:variable name="hexDigits" select="'0123456789ABCDEF'" />
	<xsl:template name="toHex">
		<xsl:param name="decimalNumber" />
		<xsl:if test="$decimalNumber &gt;= 16">
			<xsl:call-template name="toHex">
				<xsl:with-param name="decimalNumber" select="floor($decimalNumber div 16)" />
			</xsl:call-template>
		</xsl:if>
		<xsl:value-of select="substring($hexDigits, ($decimalNumber mod 16) + 1, 1)" />
	</xsl:template>

	<xsl:template name="signature">
		<p align="right"
			style="text-align: right;font-size: 10px;font-family: Verdana;line-height: 25px;">
			<table style="float: right;">
				<tr>
					<td style="width: 340px;">
						<p align="center"
							style="text-align: center;font-size: 10px;font-family: Verdana;line-height: 25px;">
							<xsl:choose>
								<xsl:when
									test="string-length(//zn:Dokument/ds:Signature/ds:SignatureValue) &gt; 0">
									<xsl:text>Dokument został podpisany, aby go zweryfikować należy użyć oprogramowania do weryfikacji podpisu</xsl:text>
									<xsl:choose>
										<xsl:when
											test="count(//zn:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']) &gt; 1">
											<br />
											<xsl:text>Daty złożenia podpisu: </xsl:text>
											<xsl:for-each
												select="//zn:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']">
												<xsl:value-of select="." />
											</xsl:for-each>
										</xsl:when>
										<xsl:when
											test="count(//zn:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']) = 1">
											<br />
											<xsl:text>Data złożenia podpisu: </xsl:text>
											<xsl:for-each
												select="//zn:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']">
												<xsl:value-of select="." />
											</xsl:for-each>
										</xsl:when>
										<xsl:when
											test="0 &gt;= count(//zn:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime'])">
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>Dokument nie zawiera podpisu</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<br />
							<span style="font-size: 7pt;font-weight: bold;">
								Podpis elektroniczny
							</span>
						</p>
					</td>
				</tr>
			</table>
		</p>
		<div style="clear: both;" />
	</xsl:template>
</xsl:stylesheet>