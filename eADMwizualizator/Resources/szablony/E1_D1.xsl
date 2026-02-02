﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ns2="http://uri.etsi.org/19522/v1#"
                xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
                xmlns:ns3="urn:oasis:names:tc:SAML:2.0:assertion"
                exclude-result-prefixes="ns2 ds ns3"
                version="1.0">

	<xsl:output method="html" encoding="utf-8" indent="yes"/>

	<!-- Szablon do formatowania daty -->
	<xsl:template name="format-datetime">
		<xsl:param name="dateTime"/>
		<xsl:variable name="date" select="substring-before($dateTime, 'T')"/>
		<xsl:variable name="time" select="substring-after($dateTime, 'T')"/>

		<xsl:variable name="year" select="substring($date, 1, 4)"/>
		<xsl:variable name="month" select="substring($date, 6, 2)"/>
		<xsl:variable name="day" select="substring($date, 9, 2)"/>

		<xsl:variable name="hour" select="substring($time, 1, 2)"/>
		<xsl:variable name="minute" select="substring($time, 4, 2)"/>
		<xsl:variable name="second" select="substring($time, 7, 2)"/>

		<xsl:value-of select="concat($day, '.', $month, '.', $year, ' ', $hour, ':', $minute, ':', $second)"/>
	</xsl:template>
	<xsl:template match="/">
		<xsl:apply-templates select="/ns2:Evidence"/>
	</xsl:template>
	<xsl:template match="/ns2:Evidence">
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
				<title>Dowód doręczenia elektronicznego</title>
				<style type="text/css">
					body { font-family: Segoe UI, Arial, sans-serif; margin: 20px; color: #333; background: #fff; }
					h1 { font-size: 1.6em; color: #0066cc; border-bottom: 2px solid #0066cc; padding-bottom: 8px; }
					h2 { font-size: 1.2em; color: #0066cc; margin-top: 20px; margin-bottom: 10px; }
					.section { background: #f8f9fa; border: 1px solid #ddd; border-radius: 6px; padding: 15px; margin-bottom: 15px; }
					table { width: 100%; border-collapse: collapse; }
					th { text-align: left; padding: 8px; background: #e9ecef; width: 240px; font-weight: 600; border-bottom: 1px solid #ddd; }
					td { padding: 8px; border-bottom: 1px solid #eee; }
					.highlight { background: #fff3cd; padding: 2px 6px; border-radius: 3px; }
					.mono { font-family: Consolas, monospace; font-size: 0.92em; }
					.status { font-weight: bold; color: #28a745; }
					a { color: #0066cc; text-decoration: none; }
					a:hover { text-decoration: underline; }
				</style>
			</head>
			<body>
				<h1>Dowód doręczenia elektronicznego</h1>

				<div class="section">
					<h2>Podstawowe informacje</h2>
					<table>
						<tr>
							<th>Identyfikator dowodu</th>
							<td class="mono">
								<xsl:value-of select="ns2:EvidenceIdentifier"/>
							</td>
						</tr>
						<tr>
							<th>Typ zdarzenia</th>
							<td>
								<xsl:choose>
									<xsl:when test="contains(ns2:ERDSEventId, 'ContentConsignment')">
										<span class="highlight">Zawiadomienie o przesyłce</span>
									</xsl:when>
									<xsl:when test="contains(ns2:ERDSEventId, 'ContentHandover')">
										<span class="highlight">Doręczenie przesyłki</span>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="ns2:ERDSEventId"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<tr>
							<th>Czas zdarzenia</th>
							<td>
								<xsl:call-template name="format-datetime">
									<xsl:with-param name="dateTime" select="EventTime"/>
								</xsl:call-template>
								<span style="color: #888; font-size: 0.9em; margin-left: 8px;">(UTC)</span>
							</td>
						</tr>
						<tr>
							<th>Czas nadania</th>
							<td>
								<xsl:call-template name="format-datetime">
									<xsl:with-param name="dateTime" select="ns2:SubmissionTime"/>
								</xsl:call-template>
								<span style="color: #888; font-size: 0.9em; margin-left: 8px;">(UTC)</span>
							</td>
						</tr>
						<tr>
							<th>Status</th>
							<td class="status">
								<xsl:value-of select="ns2:EventReasons/ns2:EventReason/Details[1]"/>
							</td>
						</tr>
					</table>
				</div>

				<div class="section">
					<h2>Nadawca</h2>
					<table>
						<tr>
							<th>Nazwa</th>
							<td>
								<xsl:value-of select="ns2:SenderDetails/ns2:Identity/ns3:Attribute[@FriendlyName='LegalName']/ns3:AttributeValue"/>
							</td>
						</tr>
						<tr>
							<th>Identyfikator</th>
							<td>
								<xsl:value-of select="ns2:SenderDetails/ns2:Identity/ns3:Attribute[@FriendlyName='LegalPersonIdentifier']/ns3:AttributeValue"/>
							</td>
						</tr>
						<tr>
							<th>Adres e-Doręczeń</th>
							<td class="mono">
								<xsl:value-of select="ns2:SenderDetails/Identifier"/>
							</td>
						</tr>
					</table>
				</div>

				<div class="section">
					<h2>Odbiorca</h2>
					<table>
						<tr>
							<th>Nazwa</th>
							<td>
								<xsl:value-of select="ns2:RecipientDetails/ns2:Identity/ns3:Attribute[@FriendlyName='LegalName']/ns3:AttributeValue"/>
							</td>
						</tr>
						<tr>
							<th>Identyfikator</th>
							<td>
								<xsl:value-of select="ns2:RecipientDetails/ns2:Identity/ns3:Attribute[@FriendlyName='LegalPersonIdentifier']/ns3:AttributeValue"/>
							</td>
						</tr>
						<tr>
							<th>Adres e-Doręczeń</th>
							<td class="mono">
								<xsl:value-of select="ns2:RecipientDetails/Identifier"/>
							</td>
						</tr>
					</table>
				</div>

				<div class="section">
					<h2>Zawartość przesyłki</h2>
					<table>
						<tr>
							<th>Liczba części</th>
							<td>
								<xsl:value-of select="ns2:UserContentInfo/ComposingParts"/>
							</td>
						</tr>
					</table>

					<xsl:if test="ns2:UserContentInfo/ns2:PartsInfo/ns2:PartInfo">
						<h2 style="font-size: 1em; margin-top: 15px;">Załączniki:</h2>
						<xsl:for-each select="ns2:UserContentInfo/ns2:PartsInfo/ns2:PartInfo">
							<h2 style="font-size: 0.95em; margin-top: 12px; margin-bottom: 5px;">
								Załącznik <xsl:value-of select="position()"/>
							</h2>
							<table style="margin-bottom: 10px;">
								<tr>
									<th>Identyfikator</th>
									<td class="mono">
										<xsl:value-of select="Identifier"/>
									</td>
								</tr>
								<tr>
									<th>Typ</th>
									<td>
										<xsl:value-of select="ContentType"/>
									</td>
								</tr>
							</table>
						</xsl:for-each>
					</xsl:if>
				</div>

				<div class="section">
					<h2>Wystawca dowodu</h2>
					<table>
						<tr>
							<th>Nazwa</th>
							<td>
								<xsl:value-of select="ns2:EvidenceIssuerDetails/ns2:Identity/ns3:Attribute[@FriendlyName='LegalName']/ns3:AttributeValue"/>
							</td>
						</tr>
						<tr>
							<th>Identyfikator</th>
							<td>
								<xsl:value-of select="ns2:EvidenceIssuerDetails/ns2:Identity/ns3:Attribute[@FriendlyName='LegalPersonIdentifier']/ns3:AttributeValue"/>
							</td>
						</tr>
						<tr>
							<th>Dokument polityki</th>
							<td style="font-size: 0.85em; word-break: break-all;">
								<a href="{ns2:EvidenceIssuerPolicyID/PolicyID}" target="_blank">
									<xsl:value-of select="ns2:EvidenceIssuerPolicyID/PolicyID"/>
								</a>
							</td>
						</tr>
					</table>
				</div>

				<div class="section">
					<p>Wizualizacja stworzona przez WUW Oddział Obiegu Dokumentów</p>
				</div>

			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>