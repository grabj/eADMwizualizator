<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:adr="http://crd.gov.pl/xml/schematy/adres/2009/11/09/" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:inst="http://crd.gov.pl/xml/schematy/instytucja/2009/11/16/" xmlns:meta="http://crd.gov.pl/xml/schematy/meta/2009/11/16/" xmlns:oso="http://crd.gov.pl/xml/schematy/osoba/2009/11/16/" xmlns:str="http://crd.gov.pl/xml/schematy/struktura/2009/11/16/" xmlns:wnio="http://epuap.gov.pl/FeResourceServlet/wzor_lokalny/umwm/10_06/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="1.0">
   <xsl:template match="/">
      <xsl:for-each select="wnio:Dokument">
         <html xmlns="http://www.w3.org/1999/xhtml">
            <head><title>Wniosek o wydanie nowego, zmianę lub przedłużenie ważności istniejącego zezwolenia na wykonywanie regularnych specjalnych przewozów osób w krajowym transporcie drogowym</title><meta http-equiv="Content-Type" content="text/html; charset=utf-8"/></head>
            <body>
               <table align="right" border="0">
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
                                    <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:MiejscowoscWniosku" />
                                 </span>
                              </xsl:if>
                           </span>
                        </td><td></td><td></td><td></td>
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
               <table align="center" cellpadding="10" frame="void" style="width: 100%; border-style: solid; border-radius: 5px;">
                  <tbody>
                     <tr>
                        <td>
                           <span style="font-size: medium;">
                              <em>
                                 <strong>1. Oznaczenie przedsiębiorcy</strong>
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
                                          <xsl:if test="../@typPodmiotu = '1'">
                                             <table border="0">
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
                                             <table cellpadding="5" frame="void" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                                <tbody>
                                                   <tr>
                                                      <td>
                                                         <em>
                                                            <strong>Adres zamieszkania</strong>
                                                         </em>
                                                         <table border="0">
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
                                                                     <p>
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
                                                                     </p>
                                                                  </td>
                                                               </tr>
                                                            </tbody>
                                                         </table>
                                                      </td>
                                                   </tr>
                                                </tbody>
                                             </table>
                                          </xsl:if>
                                       </xsl:for-each>
                                       <xsl:for-each select="wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/oso:Osoba">
                                          <xsl:if test="../@typPodmiotu = '1'">
                                             <table border="0">
                                                <tbody>
                                                   <tr>
                                                      <td>Numer telefonu</td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                   <tr>
                                                      <td>Faks</td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                   <tr>
                                                      <td>Adres poczty elektronicznej</td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="adr:Kontakt/adr:Email" />
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
                                       <xsl:for-each select="wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/inst:Instytucja">
                                          <xsl:if test="../@typPodmiotu = '2'">
                                             <table border="0">
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
                                             <table frame="void" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                                <tbody>
                                                   <tr>
                                                      <td>
                                                         <em>
                                                            <strong>Adres siedziby</strong>
                                                         </em>
                                                         <table border="0">
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
                                                            </tbody>
                                                         </table>
                                                      </td>
                                                   </tr>
                                                </tbody>
                                             </table>
                                          </xsl:if>
                                       </xsl:for-each>
                                       <xsl:for-each select="wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/inst:Instytucja">
                                          <xsl:if test="../@typPodmiotu = '2'">
                                             <table border="0">
                                                <tbody>
                                                   <tr>
                                                      <td>Numer telefonu</td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                   <tr>
                                                      <td>Faks</td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                               </span>
                                                            </xsl:if>
                                                         </span>
                                                      </td>
                                                   </tr>
                                                   <tr>
                                                      <td>Adres poczty elektronicznej</td>
                                                      <td>
                                                         <span>
                                                            <label>
                                                               <span />
                                                            </label>
                                                            <xsl:if test="true()">
                                                               <span type="text">
                                                                  <xsl:value-of select="adr:Kontakt/adr:Email" />
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
                        <td />
                     </tr>
                  </tbody>
               </table>
               <p>
                  <span>
                     <label>
                        <span />
                     </label>
                     <xsl:if test="true()">
                        <span>
                           <xsl:choose>
                              <xsl:when test="contains(concat(concat(' ', normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:PelnomocnicyCzyIstnieja)),' '),  ' 1 ' )">
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
                              <span>Pełnomocnicy</span>
                           </label>
                        </span>
                     </xsl:if>
                  </span>
               </p>
               <p />
               <xsl:for-each select="wnio:TrescDokumentu/wnio:Wartosc/wnio:Pelnomocnicy">
                  <xsl:if test="../wnio:PelnomocnicyCzyIstnieja = '1'">
                     <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px; width: 100%;">
                        <tbody>
                           <tr>
                              <td>
                                 <p>
                                    <strong>
                                       <em>2. Ustanowieni pełnomocnicy</em>
                                    </strong>
                                 </p>
                                 <xsl:for-each select="wnio:Pelnomocnik1/oso:Osoba">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <strong>
                                                         <em>Adres zamieszkania</em>
                                                      </strong>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <p />
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik2/oso:Osoba">
                                    <xsl:if test="../../../wnio:Dodaj2 = '1'">
                                       <p>______________________________________________</p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <p />
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik3/oso:Osoba">
                                    <xsl:if test="Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik4/oso:Osoba">
                                    <xsl:if test="Dodaj4 = '1' and Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik5/oso:Osoba">
                                    <xsl:if test="Dodaj5 = '1' and Dodaj4 = '1' and Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik6/oso:Osoba">
                                    <xsl:if test="Dodaj6 = '1' and Dodaj5 = '1' and Dodaj4 = '1' and Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik7/oso:Osoba">
                                    <xsl:if test="Dodaj7 = '1' and Dodaj6 = '1' and Dodaj5 = '1' and Dodaj4 = '1' and Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik8/oso:Osoba">
                                    <xsl:if test="Dodaj8 = '1' and Dodaj7 = '1' and Dodaj6 = '1' and Dodaj5 = '1' and Dodaj4 = '1' and Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik9/oso:Osoba">
                                    <xsl:if test="Dodaj9 = '1' and Dodaj8 = '1' and Dodaj7 = '1' and Dodaj6 = '1' and Dodaj5 = '1' and Dodaj4 = '1' and Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik10/oso:Osoba">
                                    <xsl:if test="Dodaj10 = '1' and Dodaj9 = '1' and Dodaj8 = '1' and Dodaj7 = '1' and Dodaj6 = '1' and Dodaj5 = '1' and Dodaj4 = '1' and Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik11/oso:Osoba">
                                    <xsl:if test="Dodaj11 = '1' and Dodaj10 = '1' and Dodaj9 = '1' and Dodaj8 = '1' and Dodaj7 = '1' and Dodaj6 = '1' and Dodaj5 = '1' and Dodaj4 = '1' and Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik12/oso:Osoba">
                                    <xsl:if test="Dodaj12 = '1' and Dodaj11 = '1' and Dodaj10 = '1' and Dodaj9 = '1' and Dodaj8 = '1' and Dodaj7 = '1' and Dodaj6 = '1' and Dodaj5 = '1' and Dodaj4 = '1' and Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik13/oso:Osoba">
                                    <xsl:if test="Dodaj13 = '1' and Dodaj12 = '1' and Dodaj11 = '1' and Dodaj10 = '1' and Dodaj9 = '1' and Dodaj8 = '1' and Dodaj7 = '1' and Dodaj6 = '1' and Dodaj5 = '1' and Dodaj4 = '1' and Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik14/oso:Osoba">
                                    <xsl:if test="Dodaj14 = '1' and Dodaj13 = '1' and Dodaj12 = '1' and Dodaj11 = '1' and Dodaj10 = '1' and Dodaj9 = '1' and Dodaj8 = '1' and Dodaj7 = '1' and Dodaj6 = '1' and Dodaj5 = '1' and Dodaj4 = '1' and Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:for-each select="wnio:Pelnomocnik15/oso:Osoba">
                                    <xsl:if test="Dodaj15 = '1' and Dodaj14 = '1' and Dodaj13 = '1' and Dodaj12 = '1' and Dodaj11 = '1' and Dodaj10 = '1' and Dodaj9 = '1' and Dodaj8 = '1' and Dodaj7 = '1' and Dodaj6 = '1' and Dodaj5 = '1' and Dodaj4 = '1' and Dodaj3 = '1' and Dodaj2 = '1'">
                                       <p>
                                          <span>______________________________________________</span>
                                       </p>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Imię</td>
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
                                                <td>Drugie imię</td>
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
                                                <td>Nazwisko</td>
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
                                          </tbody>
                                       </table>
                                       <table border="0" cellpadding="5" style="border-width: 1px; border-style: solid; border-radius: 5px;">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>
                                                      <em>
                                                         <strong>Adres zamieszkania</strong>
                                                      </em>
                                                   </p>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>Województwo</td>
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
                                                            <td>Powiat</td>
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
                                                            <td>Gmina</td>
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
                                                            <td>Miejscowość</td>
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
                                                            <td>Ulica</td>
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
                                                            <td>Nr domu</td>
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
                                                            <td>Nr lokalu</td>
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
                                                            <td>Kod pocztowy</td>
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
                                                            <td>Poczta</td>
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
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>Numer telefonu</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Telefon" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Faks</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Faks" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>Adres poczty elektronicznej</td>
                                                <td>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="adr:Kontakt/adr:Email" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                       <p />
                                    </xsl:if>
                                 </xsl:for-each>
                              </td>
                           </tr>
                        </tbody>
                     </table>
                  </xsl:if>
               </xsl:for-each>
               <p />
               <p />
               <table align="center" style="width: 100%;">
                  <tbody>
                     <tr>
                        <td>
                           <h2 style="text-align: center;">
                              <span style="font-size: medium;">
                                 <strong>WNIOSEK</strong>
                              </span>
                           </h2>
                           <h2 style="text-align: center;">
                              <span style="font-size: medium;">
                                 <strong>
                                    <span style="font-size: medium;">o udzielenie, zmianę lub przedłużenie ważności</span>
                                    zezwolenia na wykonywanie krajowego drogowego przewozu osób
                                 </strong>
                              </span>
                           </h2>
                           <p>
                              <span style="font-size: small;">
                                 <strong>
                                    <br />
                                 </strong>
                              </span>
                           </p>
                           <table border="0" style="margin-left: 50px;">
                              <tbody>
                                 <tr>
                                    <td style="width: 400px;">
                                       <strong>
                                          <span>
                                             <label>
                                                <span />
                                             </label>
                                             <xsl:if test="true()">
                                                <span>
                                                   <xsl:choose>
                                                      <xsl:when test="normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:TypWniosku) = normalize-space(' 1 ')">
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
                                                      <span>przewozy regularne</span>
                                                   </label>
                                                </span>
                                                <br />
                                                <span>
                                                   <xsl:choose>
                                                      <xsl:when test="normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:TypWniosku) = normalize-space(' 2 ')">
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
                                                      <span>przewozy regularne specjalne</span>
                                                   </label>
                                                </span>
                                             </xsl:if>
                                          </span>
                                       </strong>
                                    </td>
                                    <td>
                                       <strong>
                                          <span>
                                             <label>
                                                <span />
                                             </label>
                                             <xsl:if test="true()">
                                                <span>
                                                   <xsl:choose>
                                                      <xsl:when test="normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:RodzajWniosku) = normalize-space(' 1 ')">
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
                                                      <span>podstawowy</span>
                                                   </label>
                                                </span>
                                                <br />
                                                <span>
                                                   <xsl:choose>
                                                      <xsl:when test="normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:RodzajWniosku) = normalize-space(' 2 ')">
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
                                                      <span>zmiana zezwolenia</span>
                                                   </label>
                                                </span>
                                                <br />
                                                <span>
                                                   <xsl:choose>
                                                      <xsl:when test="normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:RodzajWniosku) = normalize-space(' 3 ')">
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
                                                      <span>przedłużenie ważności</span>
                                                   </label>
                                                </span>
                                             </xsl:if>
                                          </span>
                                       </strong>
                                    </td>
                                 </tr>
                              </tbody>
                           </table>
                           <p>
                              <span style="font-size: small;">
                                 <strong>
                                    <br />
                                 </strong>
                              </span>
                           </p>
                           <p>
                              <strong>4. Określenie rodzajów pojazdów jakimi dysponuje przedsiębiorca ubiegający się o zezwolenie</strong>
                           </p>
                           <table border="0" style="margin-left: 50px;">
                              <tbody>
                                 <tr>
                                    <td style="width: 250px;">Ilość autobusów</td>
                                    <td align="center" style="width: 200px;">
                                       <p>przewozy regularne</p>
                                       <p>
                                          <span>
                                             <label>
                                                <span />
                                             </label>
                                             <xsl:if test="true()">
                                                <span type="text">
                                                   <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:IloscAutobusow/wnio:PrzewozyRegularne" />
                                                </span>
                                             </xsl:if>
                                          </span>
                                       </p>
                                    </td>
                                    <td align="center" style="width: 200px;">
                                       <p>przewozy regularne specjalne</p>
                                       <p>
                                          <span>
                                             <label>
                                                <span />
                                             </label>
                                             <xsl:if test="true()">
                                                <span type="text">
                                                   <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:IloscAutobusow/wnio:PrzewozyRegularneSpecjalne" />
                                                </span>
                                             </xsl:if>
                                          </span>
                                       </p>
                                    </td>
                                 </tr>
                              </tbody>
                           </table>
                           <p />
                           <p>
                              <strong>5. Nr licencji na wykonywanie transportu drogowego </strong>
                              <span>
                                 <label>
                                    <span />
                                 </label>
                                 <xsl:if test="true()">
                                    <span type="text">
                                       <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:NrLicencji" />
                                    </span>
                                 </xsl:if>
                              </span>
                           </p>
                           <p />
                           <p>
                              <strong>6. Określenie zakresu zezwolenia lub zmian zezwolenia: - nazwa lini regularnej / regularnej specjalnej</strong>
                           </p>
                           <p>
                              <span>
                                 <label>
                                    <span />
                                 </label>
                                 <xsl:if test="true()">
                                    <span>
                                       <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:ZakresZezwolenia" />
                                    </span>
                                 </xsl:if>
                              </span>
                           </p>
                           <p>
                              <strong>7. Wnioskowany czas ważności zmienianego lub nowego zezwolenia</strong>
                           </p>
                           <p />
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:Wartosc/wnio:ID0">
                              <xsl:if test="../wnio:RodzajWniosku = '2' or ../wnio:RodzajWniosku = '3'">
                                 Zezwolenie Nr
                                 <span>
                                    <label>
                                       <span />
                                    </label>
                                    <xsl:if test="true()">
                                       <span type="text">
                                          <xsl:value-of select="wnio:NrZezwolenia" />
                                       </span>
                                    </xsl:if>
                                 </span>
                                 ważne do
                                 <xsl:if test="true()">
                                    <xsl:value-of select="wnio:WazneDo" />
                                 </xsl:if>
                              </xsl:if>
                           </xsl:for-each>
                           <p style="text-align: center;">
                              <strong>
                                 <br />
                                 <br />
                                 <span>
                                    <label>
                                       <span />
                                    </label>
                                    <xsl:if test="true()">
                                       <span>
                                          <xsl:choose>
                                             <xsl:when test="normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:WnioskowanyCzasWaznosci) = normalize-space(' 1 ')">
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
                                             <span>na 1 rok</span>
                                          </label>
                                       </span>
                                       <span>
                                          <xsl:choose>
                                             <xsl:when test="normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:WnioskowanyCzasWaznosci) = normalize-space(' 2 ')">
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
                                             <span>na 2 lata</span>
                                          </label>
                                       </span>
                                       <span>
                                          <xsl:choose>
                                             <xsl:when test="normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:WnioskowanyCzasWaznosci) = normalize-space(' 3 ')">
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
                                             <span>na 3 lata</span>
                                          </label>
                                       </span>
                                       <span>
                                          <xsl:choose>
                                             <xsl:when test="normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:WnioskowanyCzasWaznosci) = normalize-space(' 4 ')">
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
                                             <span>na 4 lata</span>
                                          </label>
                                       </span>
                                       <span>
                                          <xsl:choose>
                                             <xsl:when test="normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:WnioskowanyCzasWaznosci) = normalize-space(' 5 ')">
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
                                             <span>na 5 lat</span>
                                          </label>
                                       </span>
                                    </xsl:if>
                                 </span>
                              </strong>
                           </p>
                           <p />
                           <p>
                              <strong>8. Liczba wnioskowanych wypisów z zezwolenia - sztuk</strong>
                              <span>
                                 <label>
                                    <span />
                                 </label>
                                 <xsl:if test="true()">
                                    <span type="text">
                                       <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:WnioskowanaLiczbaWypisow" />
                                    </span>
                                 </xsl:if>
                              </span>
                           </p>
                           <p />
                           <p />
                           <p>
                              <strong>9. Opłaty:</strong>
                           </p>
                           <table border="0" style="margin-left: 50px;">
                              <tbody>
                                 <tr>
                                    <td>za zezwolenie</td>
                                    <td>
                                       <span>
                                          <label>
                                             <span />
                                          </label>
                                          <xsl:if test="true()">
                                             <span type="text">
                                                <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:OplataZaZezwolenie" />
                                             </span>
                                          </xsl:if>
                                       </span>
                                    </td>
                                 </tr>
                                 <tr>
                                    <td>za wypisy</td>
                                    <td>
                                       <span>
                                          <label>
                                             <span />
                                          </label>
                                          <xsl:if test="true()">
                                             <span type="text">
                                                <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:OplataZaWypisy" />
                                             </span>
                                          </xsl:if>
                                       </span>
                                    </td>
                                 </tr>
                                 <tr>
                                    <td>
                                       <strong>RAZEM:</strong>
                                    </td>
                                    <td>
                                       <span>
                                          <label>
                                             <span />
                                          </label>
                                          <xsl:if test="true()">
                                             <span type="text">
                                                <xsl:value-of select="wnio:TrescDokumentu/wnio:Wartosc/wnio:OplataRAZEM" />
                                             </span>
                                          </xsl:if>
                                       </span>
                                    </td>
                                 </tr>
                              </tbody>
                           </table>
                           <p />
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:PrzewozyRegularne">
                              <xsl:if test="../wnio:Wartosc/wnio:TypWniosku = '1'">
                                 <p>
                                    <strong>10. Do wniosku o udzielenie zezwolenia na wykonywanie przewozów regularnych w krajowym transporcie drogowym lub przedłużenie ważności zezwolenia dołączono:</strong>
                                 </p>
                                 <p>1. Kserokopia licencji na wykonywanie transportu drogowego:</p>
                                 <xsl:for-each select="wnio:Licencja">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <p />
                                 <p>2. Proponowany rozkład jazdy uwzględniający przystanki, godziny odjazdów środków transportowych, długość linii komunikacyjnej, podaną w kilometrach, i odległości między przystankami, kursy oraz liczbę pojazdów niezbędnych do wykonywania codziennych przewozów, zgodnie z rozkładem jazdy;</p>
                                 <xsl:for-each select="wnio:RozkladJazdy">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <p />
                                 <p>3. Schemat połączeń komunikacyjnych z zaznaczoną linią komunikacyjną i przystankami;</p>
                                 <xsl:for-each select="wnio:SchematPolaczen">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <p>4. Potwierdzenie uzgodnienia zasad korzystania z obiektów dworcowych i przystanków, dokonane z ich właścicielami lub zarządzającymi;</p>
                                 <xsl:for-each select="wnio:Uzgodnienia">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td valign="top">
                                                   <p>Liczba załączników</p>
                                                   <p>
                                                      <span>
                                                         <label>
                                                            <span />
                                                         </label>
                                                         <xsl:if test="true()">
                                                            <span type="text">
                                                               <xsl:value-of select="str:Zalacznik/wnio:LiczbaZalacznikow" />
                                                            </span>
                                                         </xsl:if>
                                                      </span>
                                                   </p>
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <p />
                                 <p>5. Zobowiązanie do zamieszczania informacji o godzinach odpadów na tabliczkach przystankowych na przystankach;</p>
                                 <xsl:for-each select="wnio:Zobowiazanie">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <p />
                                 <p>6. Cennik;</p>
                                 <xsl:for-each select="wnio:Cennik">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <p />
                                 <p>7. Wykaz podjazdów z określeniem ich liczby oraz liczby miejsc, którymi wnioskodawca zamierza wykonywać przewozy;</p>
                                 <xsl:for-each select="wnio:WykazPojazdow">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                              </xsl:if>
                           </xsl:for-each>
                           <p />
                           <xsl:for-each select="wnio:TrescDokumentu/wnio:PrzewozyRegularneSpecjalne">
                              <xsl:if test="../wnio:Wartosc/wnio:TypWniosku = '2'">
                                 <p>
                                    <strong>10. Do wniosku o udzielenie zezwolenia na wykonywanie przewozów regularnych specjalnych w krajowym transporcie drogowym dołączono:</strong>
                                 </p>
                                 <p />
                                 <p>1. Kserokopia licencji na wykonywanie transportu drogowego;</p>
                                 <xsl:for-each select="wnio:Licencja">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <p />
                                 <p>2. Informacja określająca grupę osób, która będzie uprawniona do korzystania z przewozu;</p>
                                 <xsl:for-each select="wnio:InformacjaOGrupieOsob">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <p />
                                 <p>3. Proponowany rozkład jazdy uwzględniający przystanki, godziny odjazdów środków transportowych, długość linii komunikacyjnej, podaną w kilometrach, i odległości między przystankami, kursy oraz liczbę pojazdów niezbędnych do wykonywania codziennych przewozów zgodnie z rozkładem jazdy;</p>
                                 <xsl:for-each select="wnio:RozkladJazdy">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <p />
                                 <p>4. Schemat połączeń komunikacyjnych z zaznaczoną linią komunikacyjną i przystankami;</p>
                                 <xsl:for-each select="wnio:TrescDokumentu/wnio:Wartosc/wnio:ID44">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <p />
                                 <p>5. Potwierdzenie uzgodnienia zasad korzystania z obiektów dworcowych i przystanków, dokonane z ich właścicielami lub zarządzającymi;</p>
                                 <xsl:for-each select="wnio:SchematPolaczen">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td valign="top">
                                                   <p>Liczba załączników</p>
                                                   <p>
                                                      <span>
                                                         <label>
                                                            <span />
                                                         </label>
                                                         <xsl:if test="true()">
                                                            <span type="text">
                                                               <xsl:value-of select="str:Zalacznik/wnio:LiczbaZalacznikow" />
                                                            </span>
                                                         </xsl:if>
                                                      </span>
                                                   </p>
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <p />
                                 <p>6. Zobowiązanie do zamieszczania informacji o godzinach odjazdów na tabliczkach przystankowych lub przystankach;</p>
                                 <xsl:for-each select="wnio:Zobowiazanie">
                                    <xsl:if test="true()">
                                       <table border="0">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <p>Opis załącznika</p>
                                                   <span>
                                                      <label>
                                                         <span />
                                                      </label>
                                                      <xsl:if test="true()">
                                                         <span type="text">
                                                            <xsl:value-of select="str:Zalacznik/str:OpisZalacznika" />
                                                         </span>
                                                      </xsl:if>
                                                   </span>
                                                   <p />
                                                </td>
                                                <td>
                                                   <table border="0">
                                                      <tbody>
                                                         <tr>
                                                            <td>
                                                               <span>
                                                                  <label>
                                                                     <span />
                                                                  </label>
                                                                  <xsl:value-of select="str:Zalacznik/str:DaneZalacznika/../@nazwaPliku" />
                                                               </span>
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </xsl:if>
                                 </xsl:for-each>
                              </xsl:if>
                           </xsl:for-each>
                           <p>
                              <span style="font-size: 8pt;" />
                           </p>
                           <p>
                              <strong>
                                 11. Forma odbioru
                                 <span>
                                    <label>
                                       <span />
                                    </label>
                                    <xsl:if test="true()">
                                       <span>
                                          <xsl:choose>
                                             <xsl:when test="normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:FormaOdbioru) = normalize-space(' 1 ')">
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
                                             <span>odbiór osobisty</span>
                                          </label>
                                       </span>
                                       <span>
                                          <xsl:choose>
                                             <xsl:when test="normalize-space(wnio:TrescDokumentu/wnio:Wartosc/wnio:FormaOdbioru) = normalize-space(' 2 ')">
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
                                             <span>przesłać pocztą</span>
                                          </label>
                                       </span>
                                    </xsl:if>
                                 </span>
                              </strong>
                           </p>
                           <p />
                        </td>
                     </tr>
                  </tbody>
               </table>
               <table align="center" cellpadding="10" frame="void" style="width: 100%; border-style: solid; border-radius: 5px;">
                  <tbody>
                     <tr>
                        <td>
                           <span style="font-size: medium;">
                              <em>
                                 <strong>Załączniki</strong>
                              </em>
                           </span>
                        </td>
                     </tr>
                     <tr>
                        <td>
                           <xsl:for-each select="wnio:TrescDokumentu/str:Zalaczniki/str:Zalacznik">
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
                  </tbody>
               </table>
            </body>
         </html>
      </xsl:for-each>
   </xsl:template>
</xsl:stylesheet>