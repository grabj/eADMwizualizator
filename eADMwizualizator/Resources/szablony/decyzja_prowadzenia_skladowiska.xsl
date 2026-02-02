<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:adr="http://crd.gov.pl/xml/schematy/adres/2009/11/09/" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:inst="http://crd.gov.pl/xml/schematy/instytucja/2009/11/16/" xmlns:meta="http://crd.gov.pl/xml/schematy/meta/2009/11/16/" xmlns:oso="http://crd.gov.pl/xml/schematy/osoba/2009/11/16/" xmlns:str="http://crd.gov.pl/xml/schematy/struktura/2009/11/16/" xmlns:wnio="http://epuap.gov.pl/FeResourceServlet/wzor_lokalny/umwm/5_24/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="1.0">
   <xsl:template match="/">
      <xsl:for-each select="wnio:Dokument">
         <html xmlns="http://www.w3.org/1999/xhtml">
            <head><title>Wniosek o wydanie decyzji zatwierdzającej instrukcję prowadzenia składowiska</title><meta http-equiv="Content-Type" content="text/html; charset=utf-8"/></head>
            <body>
               <table align="right" border="0" cellspacing="0" style="width: 55%; float: right;">
                  <tbody>
                     <tr>
                        <td>
                           Miejscowość
                           <span>
                              <label>
                                 <span />
                              </label>
                              <xsl:if test="true()">
                                 <span type="text">
                                    <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:Miejscowosc" />
                                 </span>
                              </xsl:if>
                           </span>
                        </td>
                        <td>
                           Data
                           <xsl:if test="true()">
                              <xsl:value-of select="wnio:DaneDokumentu/meta:Data/meta:Czas" />
                           </xsl:if>
                        </td>
                     </tr>
                  </tbody>
               </table>
               <p />
               <table align="center" border="0" style="width: 751px;">
                  <tbody>
                     <tr>
                        <td>
                           <span style="font-size: medium;">
                              <em>
                                 <strong>Wnioskodawca</strong>
                              </em>
                           </span>
                           <p>
                              <span>
                                 <span>
                                    <label>
                                       <span />
                                    </label>
                                    <xsl:if test="true()">
                                       <span>
                                          <xsl:choose>
                                             <xsl:when test="normalize-space(wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/@typPodmiotu) = normalize-space(' 1 ')">
                                                <span>
                                                   [
                                                   <b>X</b>
                                                   ]
                                                </span>
                                             </xsl:when>
                                             <xsl:otherwise>
                                                <span>[ ]</span>
                                             </xsl:otherwise>
                                          </xsl:choose>
                                          <label>
                                             <span>Osoba fizyczna</span>
                                          </label>
                                       </span>
                                       <br />
                                       <span>
                                          <xsl:choose>
                                             <xsl:when test="normalize-space(wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/@typPodmiotu) = normalize-space(' 2 ')">
                                                <span>
                                                   [
                                                   <b>X</b>
                                                   ]
                                                </span>
                                             </xsl:when>
                                             <xsl:otherwise>
                                                <span>[ ]</span>
                                             </xsl:otherwise>
                                          </xsl:choose>
                                          <label>
                                             <span>Osoba prawna/instytucja</span>
                                          </label>
                                       </span>
                                    </xsl:if>
                                 </span>
                              </span>
                           </p>
                           <table border="0">
                              <tbody>
                                 <tr>
                                    <td>
                                       <xsl:for-each select="wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/oso:Osoba">
                                          <xsl:if test="contains(../@typPodmiotu,'1')">
                                             <table border="0" cellspacing="0">
                                                <tbody>
                                                   <tr>
                                                      <td>
                                                         <span>Imię</span>
                                                      </td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="oso:Imie" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                   <tr>
                                                      <td>
                                                         <span>Drugie imię</span>
                                                      </td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="oso:ImieDrugie" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                   <tr>
                                                      <td>
                                                         <span>Nazwisko</span>
                                                      </td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="oso:Nazwisko" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                   <tr>
                                                      <td>PESEL</td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="oso:IdOsoby/oso:PESEL" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                </tbody>
                                             </table>
                                             <span style="font-size: 8pt;" />
                                             <table border="0" cellspacing="0" frame="void">
                                                <tbody>
                                                   <tr>
                                                      <td>
                                                         <em>
                                                            <strong>Adres zamieszkania</strong>
                                                         </em>
                                                         <table border="0" cellspacing="0">
                                                            <tbody>
                                                               <tr>
                                                                  <td>
                                                                     <span>Województwo</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span>
                                                                              <xsl:value-of select="adr:Adres/adr:Wojewodztwo" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Powiat</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span>
                                                                              <xsl:value-of select="adr:Adres/adr:Powiat" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Gmina</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span>
                                                                              <xsl:value-of select="adr:Adres/adr:Gmina" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Miejscowość</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span>
                                                                              <xsl:value-of select="adr:Adres/adr:Miejscowosc" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Ulica</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span>
                                                                              <xsl:value-of select="adr:Adres/adr:Ulica" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Nr domu</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span type="text">
                                                                              <xsl:value-of select="adr:Adres/adr:Budynek" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Nr lokalu</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span type="text">
                                                                              <xsl:value-of select="adr:Adres/adr:Lokal" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Kod pocztowy</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span type="text">
                                                                              <xsl:value-of select="adr:Adres/adr:KodPocztowy" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Poczta</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span type="text">
                                                                              <xsl:value-of select="adr:Adres/adr:Poczta" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td />
                                                                  <td />
                                                               </tr>
                                                            </tbody>
                                                         </table>
                                                      </td>
                                                   </tr>
                                                </tbody>
                                             </table>
                                          </xsl:if>
                                       </xsl:for-each>
                                    </td>
                                    <td>
                                       <xsl:for-each select="wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/inst:Instytucja">
                                          <xsl:if test="contains(../@typPodmiotu,'2')">
                                             <table border="0" cellspacing="0">
                                                <tbody>
                                                   <tr>
                                                      <td>
                                                         <span>Nazwa</span>
                                                      </td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="inst:NazwaInstytucji" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                   <tr>
                                                      <td>
                                                         <span>NIP</span>
                                                      </td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="inst:IdInstytucji/inst:NIP" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                   <tr>
                                                      <td>
                                                         <span>REGON</span>
                                                      </td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="inst:IdInstytucji/inst:REGON" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                   <tr>
                                                      <td>
                                                         <span>KRS</span>
                                                      </td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="inst:IdInstytucji/inst:KRS" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                </tbody>
                                             </table>
                                             <span style="font-size: 8pt;" />
                                             <table border="0" cellspacing="0" frame="void">
                                                <tbody>
                                                   <tr>
                                                      <td>
                                                         <em>
                                                            <strong>Adres siedziby</strong>
                                                         </em>
                                                         <table border="0" cellspacing="0">
                                                            <tbody>
                                                               <tr>
                                                                  <td>
                                                                     <span>Województwo</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span>
                                                                              <xsl:value-of select="adr:Adres/adr:Wojewodztwo" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Powiat</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span>
                                                                              <xsl:value-of select="adr:Adres/adr:Powiat" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Gmina</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span>
                                                                              <xsl:value-of select="adr:Adres/adr:Gmina" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Miejscowość</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span>
                                                                              <xsl:value-of select="adr:Adres/adr:Miejscowosc" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Ulica</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span>
                                                                              <xsl:value-of select="adr:Adres/adr:Ulica" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Nr domu</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span type="text">
                                                                              <xsl:value-of select="adr:Adres/adr:Budynek" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Nr lokalu</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span type="text">
                                                                              <xsl:value-of select="adr:Adres/adr:Lokal" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Kod pocztowy</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span type="text">
                                                                              <xsl:value-of select="adr:Adres/adr:KodPocztowy" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td>
                                                                     <span>Poczta</span>
                                                                  </td>
                                                                  <td>
                                                                     <span>
                                                                        <label>
                                                                           <span />
                                                                        </label>
                                                                        <xsl:if test="true()">
                                                                           <span type="text">
                                                                              <xsl:value-of select="adr:Adres/adr:Poczta" />
                                                                           </span>
                                                                        </xsl:if>
                                                                     </span>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td />
                                                                  <td />
                                                               </tr>
                                                            </tbody>
                                                         </table>
                                                      </td>
                                                   </tr>
                                                </tbody>
                                             </table>
                                          </xsl:if>
                                       </xsl:for-each>
                                    </td>
                                 </tr>
                                 <tr>
                                    <td colspan="2">
                                       <table border="0" cellspacing="0">
                                          <tbody>
                                             <tr>
                                                <td style="width: 165px;">
                                                   Adres
                                                   <span class="editorInputCell">składowiska odpadów</span>
                                                </td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:AdresSkladowiska" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </td>
                                 </tr>
                                 <tr>
                                    <td>
                                       <xsl:for-each select="wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/oso:Osoba/adr:Kontakt">
                                          <xsl:if test="contains(/wnio:Dokument/wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/@typPodmiotu,'1')">
                                             <table border="0" cellspacing="0" style="width: 316px;">
                                                <tbody>
                                                   <tr>
                                                      <td style="width: 165px;">Telefon kontaktowy</td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="adr:Telefon" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                </tbody>
                                             </table>
                                          </xsl:if>
                                       </xsl:for-each>
                                    </td>
                                    <td>
                                       <xsl:for-each select="wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/inst:Instytucja/adr:Kontakt">
                                          <xsl:if test="contains(/wnio:Dokument/wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/@typPodmiotu,'2')">
                                             <table border="0" cellspacing="0" style="width: 316px;">
                                                <tbody>
                                                   <tr>
                                                      <td style="width: 165px;">Telefon kontaktowy</td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="adr:Telefon" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                </tbody>
                                             </table>
                                          </xsl:if>
                                       </xsl:for-each>
                                    </td>
                                 </tr>
                              </tbody>
                           </table>
                        </td>
                     </tr>
                  </tbody>
               </table>
               <table align="right">
                  <tbody>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:DaneDokumentu/str:Adresaci/meta:Podmiot/inst:Instytucja">
                              <xsl:if test="true()">
                                 <p>
                                    <span>
                                       <label>
                                          <span />
                                       </label>
                                       <xsl:if test="true()">
                                          <span type="text">
                                             <xsl:value-of select="inst:NazwaInstytucji" />
                                          </span>
                                       </xsl:if>
                                    </span>
                                 </p>
                                 <p>
                                    <span>
                                       <label>
                                          <span />
                                       </label>
                                       <xsl:if test="true()">
                                          <span type="text">
                                             <xsl:value-of select="adr:Adres/adr:Ulica" />
                                          </span>
                                       </xsl:if>
                                    </span>
                                    <span>
                                       <label>
                                          <span />
                                       </label>
                                       <xsl:if test="true()">
                                          <span type="text">
                                             <xsl:value-of select="adr:Adres/adr:Budynek" />
                                          </span>
                                       </xsl:if>
                                    </span>
                                 </p>
                                 <p>
                                    <span>
                                       <label>
                                          <span />
                                       </label>
                                       <xsl:if test="true()">
                                          <span type="text">
                                             <xsl:value-of select="adr:Adres/adr:KodPocztowy" />
                                          </span>
                                       </xsl:if>
                                    </span>
                                    <span>
                                       <label>
                                          <span />
                                       </label>
                                       <xsl:if test="true()">
                                          <span type="text">
                                             <xsl:value-of select="adr:Adres/adr:Miejscowosc" />
                                          </span>
                                       </xsl:if>
                                    </span>
                                 </p>
                              </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                  </tbody>
               </table>
               
               <table align="center" style="width: 751px; clear: both;">
                  <tbody>
                     <tr>
                        <td>
                           <p style="text-align: center;">
                              <span style="font-size: small;">
                                 <strong>
                                    WNIOSEK O WYDANIE DECYZJI ZATWIERDZAJĄCEJ
                                    <br />
                                 </strong>
                              </span>
                           </p>
                           <p style="text-align: center;">
                              <span style="font-size: small;">
                                 <strong>INSTRUKCJĘ PROWADZENIA SKŁADOWISKA</strong>
                              </span>
                           </p>
                        </td>
                     </tr>
                  </tbody>
               </table>
               <table align="center" border="0" style="width: 751px;">
                  <tbody>
                     <tr>
                        <td>
                           <p style="text-align: justify;">Na podstawie art. 129 ustawy z dnia 14 grudnia 2012 r. (Dz. U. z 2013 r. poz. 21, z późn. zm.) wnoszę o wydanie decyzji zatwierdzającej instrukcję prowadzenia składowiska:</p>
                        </td>
                     </tr>
                     <tr>
                        <td>
                           <span>
                              <label>
                                 <span />
                              </label>
                              <xsl:if test="true()">
                                 <span type="text">
                                    <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:Skladowisko" />
                                 </span>
                              </xsl:if>
                           </span>
                           <p>
                              zlokalizowanego w
                              <span>
                                 <label>
                                    <span />
                                 </label>
                                 <xsl:if test="true()">
                                    <span type="text">
                                       <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiejscowoscSkladowiska" />
                                    </span>
                                 </xsl:if>
                              </span>
                           </p>
                           <p>
                              dla
                              <span>
                                 <label>
                                    <span />
                                 </label>
                                 <xsl:if test="true()">
                                    <span type="text">
                                       <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:Prowadzacy" />
                                    </span>
                                 </xsl:if>
                              </span>
                           </p>
                           <p style="text-align: left;">
                              Numer Księgi wieczystej dla nieruchomości, na których położone jest składowisko odpadów:
                              <span>
                                 <label>
                                    <span />
                                 </label>
                                 <xsl:if test="true()">
                                    <span type="text">
                                       <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:NrKW" />
                                    </span>
                                 </xsl:if>
                              </span>
                           </p>
                           <p style="text-align: justify;">Informacja o wydanym pozwoleniu na użytkowanie składowiska odpadów (sygnatura decyzji, organ wydający, data wydania decyzji)</p>
                           <p>
                              <span>
                                 <label>
                                    <span />
                                 </label>
                                 <xsl:if test="true()">
                                    <span>
                                       <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:InfoPozwolenieUzytkowanie" />
                                    </span>
                                 </xsl:if>
                              </span>
                           </p>
                           <p style="text-align: justify;">Informacja o uzyskanym pozwoleniu zintegrowanym albo zezwoleniu na przetwarzanie odpadów (sygnatura decyzji, organ wydający, data wydania decyzji)</p>
                           <p>
                              <span>
                                 <label>
                                    <span />
                                 </label>
                                 <xsl:if test="true()">
                                    <span>
                                       <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:InfoPozwolenieZintegrowane" />
                                    </span>
                                 </xsl:if>
                              </span>
                           </p>
                           <p style="text-align: justify;">Informacja o proponowanej formie i wysokości zabezpieczeń roszczeń o którym mowa w art. 125 ustawy z dnia 14 grudnia 2012 r. (Dz. U. z 2013 r. poz. 21, z późn. zm.)</p>
                           <p>
                              <span>
                                 <label>
                                    <span />
                                 </label>
                                 <xsl:if test="true()">
                                    <span>
                                       <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:InfoZabezpieczenieRoszczen" />
                                    </span>
                                 </xsl:if>
                              </span>
                           </p>
                           <p style="text-align: justify;">
                              <strong>UWAGA:</strong>
                              Jeśli zabezpieczenie roszczeń dla przedmiotowego składowiska zostało już ustanowione przez wnioskodawcę, należy w powyższej informacji wpisać wysokość i formę zabezpieczenia wraz z informacją, że jest ono zgodne z art. 125 ust. 4 i 131 ust 4 ustawy o odpadach oraz załączyć oryginał zabezpieczenia roszczeń. Nie należy załączać kopii zabezpieczeń niezgodnych z powyższymi przepisami, gdyż będzie to skutkowało wezwaniem do uzupełnienia wniosku w trybie art. 64 § 2 kpa, co może skutkować pozostawieniem sprawy bez rozpoznania.
                              <strong>Zabezpieczenie roszczeń powinno stwierdzać, że w razie wystąpienia negatywnych skutków w środowisku lub szkód w środowisku, bank lub firma ubezpieczeniowa ureguluje zobowiązania na rzecz tut. organu, po orzeczeniu, w drodze decyzji tut. organu, o przeznaczeniu środków z zabezpieczenia roszczeń na usunięcie tych skutków, o ile działań tych nie wykonał na własny koszt zarządzający składowiskiem odpadów.</strong>
                           </p>
                        </td>
                     </tr>
                  </tbody>
               </table>
               <table align="center" border="0" style="width: 751px;">
                  <tbody>
                     <tr>
                        <td />
                     </tr>
                  </tbody>
               </table>
               <table align="center" border="0" style="width: 751px;">
                  <tbody>
                     <tr>
                        <td>
                           <p>
                              <span style="font-size: small;">
                                 <strong>Załączniki do wniosku:</strong>
                              </span>
                           </p>
                        </td>
                     </tr>
                     <tr>
                        <td>
                           1. Instrukcja prowadzenia składowiska odpadów obejmująca fazę eksploatacyjną i poeksploatacyjną sporządzona przez
                           <p>
                              <span>
                                 <label>
                                    <span />
                                 </label>
                                 <xsl:if test="true()">
                                    <span type="text">
                                       <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:SporzadzajacyInstrukcje" />
                                    </span>
                                 </xsl:if>
                              </span>
                              miesiąc
                              <span>
                                 <label>
                                    <span />
                                 </label>
                                 <xsl:if test="true()">
                                    <span>
                                       <xsl:variable name="ComboID620">Styczeń</xsl:variable>
                                       <xsl:if test="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiesiacInstrukcji = $ComboID620">Styczeń</xsl:if>
                                       <xsl:variable name="ComboID621">Luty</xsl:variable>
                                       <xsl:if test="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiesiacInstrukcji = $ComboID621">Luty</xsl:if>
                                       <xsl:variable name="ComboID622">Marzec</xsl:variable>
                                       <xsl:if test="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiesiacInstrukcji = $ComboID622">Marzec</xsl:if>
                                       <xsl:variable name="ComboID623">Kwiecień</xsl:variable>
                                       <xsl:if test="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiesiacInstrukcji = $ComboID623">Kwiecień</xsl:if>
                                       <xsl:variable name="ComboID624">Maj</xsl:variable>
                                       <xsl:if test="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiesiacInstrukcji = $ComboID624">Maj</xsl:if>
                                       <xsl:variable name="ComboID625">Czerwiec</xsl:variable>
                                       <xsl:if test="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiesiacInstrukcji = $ComboID625">Czerwiec</xsl:if>
                                       <xsl:variable name="ComboID626">Lipiec</xsl:variable>
                                       <xsl:if test="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiesiacInstrukcji = $ComboID626">Lipiec</xsl:if>
                                       <xsl:variable name="ComboID627">Sierpień</xsl:variable>
                                       <xsl:if test="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiesiacInstrukcji = $ComboID627">Sierpień</xsl:if>
                                       <xsl:variable name="ComboID628">Wrzesień</xsl:variable>
                                       <xsl:if test="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiesiacInstrukcji = $ComboID628">Wrzesień</xsl:if>
                                       <xsl:variable name="ComboID629">Październik</xsl:variable>
                                       <xsl:if test="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiesiacInstrukcji = $ComboID629">Październik</xsl:if>
                                       <xsl:variable name="ComboID6210">Listopad</xsl:variable>
                                       <xsl:if test="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiesiacInstrukcji = $ComboID6210">Listopad</xsl:if>
                                       <xsl:variable name="ComboID6211">Grudzień</xsl:variable>
                                       <xsl:if test="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiesiacInstrukcji = $ComboID6211">Grudzień</xsl:if>
                                    </span>
                                 </xsl:if>
                              </span>
                              rok
                              <span>
                                 <label>
                                    <span />
                                 </label>
                                 <xsl:if test="true()">
                                    <span type="text">
                                       <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:RokInstrukcji" />
                                    </span>
                                 </xsl:if>
                              </span>
                           </p>
                        </td>
                     </tr>
                     <tr>
                        <td>(sporządzona zgodnie z art. 129 ust 4 ustawy o odpadach)</td>
                     </tr>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:Instrukcja/str:Zalaczniki/str:Zalacznik">
                              <xsl:if test="true()">
                                 <table border="0">
                                    <tbody>
                                       <tr>
                                          <td>
                                             Opis załącznika
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:if test="true()">
                                                   <span type="text">
                                                      <xsl:value-of select="str:OpisZalacznika" />
                                                   </span>
                                                </xsl:if>
                                             </span>
                                          </td>
                                          <td>
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:value-of select="str:DaneZalacznika/../@nazwaPliku" />
                                             </span>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                     <tr>
                        <td style="text-align: justify;" />
                     </tr>
                     <tr>
                        <td style="text-align: justify;">2. Dokumenty potwierdzające posiadanie tytułu prawnego do dysponowania całą nieruchomością, na której jest zlokalizowane składowisko wraz ze wszystkimi instalacjami i urządzeniami, związanymi z prowadzeniem składowiska w okresie obejmującym fazę eksploatacyjną i poeksploatacyjną wraz z aktualnym wypisem z rejestru i odpisem z księgi wieczystej</td>
                     </tr>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:TytulPrawny/str:Zalaczniki/str:Zalacznik">
                              <xsl:if test="true()">
                                 <table border="0">
                                    <tbody>
                                       <tr>
                                          <td>
                                             Opis załącznika
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:if test="true()">
                                                   <span type="text">
                                                      <xsl:value-of select="str:OpisZalacznika" />
                                                   </span>
                                                </xsl:if>
                                             </span>
                                          </td>
                                          <td>
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:value-of select="str:DaneZalacznika/../@nazwaPliku" />
                                             </span>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                     <tr>
                        <td />
                     </tr>
                     <tr>
                        <td style="text-align: justify;">3. Kopia świadectwa stwierdzającego kwalifikacje kierownika składowiska odpadów w zakresie gospodarowania odpadami, odpowiednie do prowadzonych procesów przetwarzania odpadów</td>
                     </tr>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:KwalifikacjeKierown/str:Zalaczniki/str:Zalacznik">
                              <xsl:if test="true()">
                                 <table border="0">
                                    <tbody>
                                       <tr>
                                          <td>
                                             Opis załącznika
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:if test="true()">
                                                   <span type="text">
                                                      <xsl:value-of select="str:OpisZalacznika" />
                                                   </span>
                                                </xsl:if>
                                             </span>
                                          </td>
                                          <td>
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:value-of select="str:DaneZalacznika/../@nazwaPliku" />
                                             </span>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                     <tr>
                        <td />
                     </tr>
                     <tr>
                        <td style="text-align: justify;">4. Kopia pozwolenia na budowę składowiska, wraz z kopią dokumentacji technicznej stanowiącej załącznik do pozwolenia na budowę (części dotyczącej docelowej rzędnej i pojemności składowiska odpadów oraz kierunku jego rekultywacji) w celu wykluczenia podstawy do odmowy zatwierdzenia instrukcji prowadzenia składowiska zawartej w art. 134 ustawy o odpadach</td>
                     </tr>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:PozwolenieNaBudowe/str:Zalaczniki/str:Zalacznik">
                              <xsl:if test="true()">
                                 <table border="0">
                                    <tbody>
                                       <tr>
                                          <td>
                                             Opis załącznika
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:if test="true()">
                                                   <span type="text">
                                                      <xsl:value-of select="str:OpisZalacznika" />
                                                   </span>
                                                </xsl:if>
                                             </span>
                                          </td>
                                          <td>
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:value-of select="str:DaneZalacznika/../@nazwaPliku" />
                                             </span>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                     <tr>
                        <td />
                     </tr>
                     <tr>
                        <td>5. Kopia pozwolenia na użytkowanie składowiska</td>
                     </tr>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:PozwolenieNaUzytkowanie/str:Zalaczniki/str:Zalacznik">
                              <xsl:if test="true()">
                                 <table border="0">
                                    <tbody>
                                       <tr>
                                          <td>
                                             Opis załącznika
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:if test="true()">
                                                   <span type="text">
                                                      <xsl:value-of select="str:OpisZalacznika" />
                                                   </span>
                                                </xsl:if>
                                             </span>
                                          </td>
                                          <td>
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:value-of select="str:DaneZalacznika/../@nazwaPliku" />
                                             </span>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                     <tr>
                        <td />
                     </tr>
                     <tr>
                        <td>6. Kopia pozwolenia zintegrowanego albo zezwolenia na przetwarzanie odpadów</td>
                     </tr>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:PozwolZintegrZezwPrzetwOdpadow/str:Zalaczniki/str:Zalacznik">
                              <xsl:if test="true()">
                                 <table border="0">
                                    <tbody>
                                       <tr>
                                          <td>
                                             Opis załącznika
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:if test="true()">
                                                   <span type="text">
                                                      <xsl:value-of select="str:OpisZalacznika" />
                                                   </span>
                                                </xsl:if>
                                             </span>
                                          </td>
                                          <td>
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:value-of select="str:DaneZalacznika/../@nazwaPliku" />
                                             </span>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                     <tr>
                        <td />
                     </tr>
                     <tr>
                        <td>7. Aktualny odpis KRS (jeżeli prowadzący instalację nie jest osobą fizyczną)</td>
                     </tr>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:OdpisKRS/str:Zalaczniki/str:Zalacznik">
                              <xsl:if test="true()">
                                 <table border="0">
                                    <tbody>
                                       <tr>
                                          <td>
                                             Opis załącznika
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:if test="true()">
                                                   <span type="text">
                                                      <xsl:value-of select="str:OpisZalacznika" />
                                                   </span>
                                                </xsl:if>
                                             </span>
                                          </td>
                                          <td>
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:value-of select="str:DaneZalacznika/../@nazwaPliku" />
                                             </span>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                     <tr>
                        <td />
                     </tr>
                     <tr>
                        <td>8. Pełnomocnictwo (jeśli zostało udzielone osobie działającej w imieniu wnioskodawcy)</td>
                     </tr>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:Pelnomocnictwo/str:Zalaczniki/str:Zalacznik">
                              <xsl:if test="true()">
                                 <table border="0">
                                    <tbody>
                                       <tr>
                                          <td>
                                             Opis załącznika
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:if test="true()">
                                                   <span type="text">
                                                      <xsl:value-of select="str:OpisZalacznika" />
                                                   </span>
                                                </xsl:if>
                                             </span>
                                          </td>
                                          <td>
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:value-of select="str:DaneZalacznika/../@nazwaPliku" />
                                             </span>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                     <tr>
                        <td />
                     </tr>
                     <tr>
                        <td>9. Potwierdzenie wniesienia opłaty skarbowej od wniosku i pełnomocnictwa</td>
                     </tr>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:OplataSkarb/str:Zalaczniki/str:Zalacznik">
                              <xsl:if test="true()">
                                 <table border="0">
                                    <tbody>
                                       <tr>
                                          <td>
                                             Opis załącznika
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:if test="true()">
                                                   <span type="text">
                                                      <xsl:value-of select="str:OpisZalacznika" />
                                                   </span>
                                                </xsl:if>
                                             </span>
                                          </td>
                                          <td>
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:value-of select="str:DaneZalacznika/../@nazwaPliku" />
                                             </span>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                     <tr>
                        <td />
                     </tr>
                     <tr>
                        <td>10. Fakultatywnie: ewentualne upoważnienie udzielone osobie działającej w imieniu wnioskodawcy</td>
                     </tr>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:Upowaznienie/str:Zalaczniki/str:Zalacznik">
                              <xsl:if test="true()">
                                 <table border="0">
                                    <tbody>
                                       <tr>
                                          <td>
                                             Opis załącznika
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:if test="true()">
                                                   <span type="text">
                                                      <xsl:value-of select="str:OpisZalacznika" />
                                                   </span>
                                                </xsl:if>
                                             </span>
                                          </td>
                                          <td>
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:value-of select="str:DaneZalacznika/../@nazwaPliku" />
                                             </span>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                     <tr>
                        <td />
                     </tr>
                     <tr>
                        <td>11. Inne</td>
                     </tr>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:Inne/str:Zalaczniki/str:Zalacznik">
                              <xsl:if test="true()">
                                 <table border="0">
                                    <tbody>
                                       <tr>
                                          <td>
                                             Opis załącznika
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:if test="true()">
                                                   <span type="text">
                                                      <xsl:value-of select="str:OpisZalacznika" />
                                                   </span>
                                                </xsl:if>
                                             </span>
                                          </td>
                                          <td>
                                             <span>
                                                <label>
                                                   <span />
                                                </label>
                                                <xsl:value-of select="str:DaneZalacznika/../@nazwaPliku" />
                                             </span>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                     <tr>
                        <td />
                     </tr>
                  </tbody>
               </table>
            </body>
         </html>
      </xsl:for-each>
   </xsl:template>
</xsl:stylesheet>