<?xml version="1.0" encoding="UTF-8"?><!-- Version 1.0 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:oso="http://crd.gov.pl/xml/schematy/osoba/2009/11/16/" xmlns:wnio="http://crd.gov.pl/wzor/2021/09/01/10856/" version="1.0">

    <xsl:template match="/">
        <xsl:apply-templates select="wnio:Dokument"/>
    </xsl:template>

    <xsl:template match="wnio:Dokument">
        <xsl:param name="tresc" select="wnio:TrescDokumentu"/>
        <html lang="pl">

            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title>Dowód otrzymania wiadomości</title>
            </head>

            <body>
                <div class="du-view">
                    <section>
                        <div class="du-col-12 du-center du-margin-top-25">
                            <h1>
                                <xsl:value-of select="$tresc/wnio:DaneDokumentu/wnio:TytulDokumentu"/>
                            </h1>
                        </div>
                    </section>

                    <section>
                        <div class="du-col-12 du-center">
                            <br/>
                            <xsl:value-of select="$tresc/wnio:DaneDokumentu/wnio:OpisDokumentu"/>
                            <br/>
                            <br/>
                            <br/>
                        </div>
                    </section>

                    <section>
                        <div class="du-col-12 du-left du-margin-top-25">
                            <xsl:call-template name="DaneNadawcy"/>
                        </div>
                    </section>

                    <section>
                        <div class="du-col-12 du-left du-margin-top-25">
                            <xsl:call-template name="DaneAdresata"/>
                        </div>
                    </section>

                    <section>
                        <div class="du-col-12 du-left du-margin-top-25">
                            <xsl:call-template name="DataWyslania"/>
                        </div>
                    </section>

                    <section>
                        <div class="du-col-12 du-left du-margin-top-25">
                            <xsl:call-template name="DataOdbioru"/>
                        </div>
                    </section>

                    <section>
                        <div class="du-col-12 du-left du-margin-top-25">
                            <xsl:call-template name="DaneWiadomosci"/>
                        </div>
                    </section>

                    <section>
                        <div class="du-col-12 du-left du-margin-top-25">
                            <xsl:call-template name="InformacjeZalaczniki"/>
                        </div>
                    </section>

                    <section>
                        <div class="du-col-12 du-left du-margin-top-25">
                            <xsl:call-template name="DaneUslugaNadawcy"/>
                        </div>
                    </section>

                    <section>
                        <div class="du-col-12 du-left du-margin-top-25">
                            <xsl:call-template name="DaneUslugaAdresata"/>
                        </div>
                    </section>

                    <section>
                        <div class="footer-9 du-col-12 du-center">
                            <xsl:value-of select="$tresc/wnio:Stopka"/>
                        </div>
                    </section>
                </div>
                <xsl:call-template name="styleCSS"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="DaneNadawcy">
        <xsl:param name="daneNadawcy" select="wnio:TrescDokumentu/wnio:DaneNadawcy"/>
        <div class="du-margin-top-15 du-bold pb-8">Nadawca</div>
        <div class="du-col-12 pb-3">
            <div class="row">
                <div class="du-col-5 du-inline">
                    Adres do e-doręczeń nadawcy
                </div>
                <div class="du-col-7 du-inline du-bold">
                    <xsl:value-of select="$daneNadawcy/wnio:AdresEDoreczen"/>
                </div>
            </div>
        </div>
        <div class="du-col-12 pb-3">
            <div>Dane nadawcy
                <xsl:if test="$daneNadawcy/wnio:StronaKorespondencji/wnio:Rodzaj = 'osoba fizyczna'">
                    <xsl:call-template name="DaneOsobyFizycznej">
                        <xsl:with-param name="daneOsoby" select="$daneNadawcy/wnio:StronaKorespondencji/wnio:OsobaFizyczna"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="$daneNadawcy/wnio:StronaKorespondencji/wnio:Rodzaj = 'osoba prawna'">
                    <xsl:call-template name="DaneOsobyPrawnej">
                        <xsl:with-param name="daneOsoby" select="$daneNadawcy/wnio:StronaKorespondencji/wnio:OsobaPrawna"/>
                    </xsl:call-template>
                </xsl:if>
            </div>
            <div class="du-col-12 du-no-mt du-margin-bottom-15">Dane użytkownika upoważnionego<br/>przez nadawcę
                <br/>
                <xsl:call-template name="DaneOsobyFizycznej">
                    <xsl:with-param name="daneOsoby" select="$daneNadawcy/wnio:UzytkownikUpowazniony"/>
                </xsl:call-template>
            </div>
        </div>
        <br/>
    </xsl:template>

    <xsl:template name="DaneOsobyFizycznej">
        <xsl:param name="daneOsoby"/>
        <div class="row pb-3">
            <div class="du-col-5 du-inline pl-15">Imię</div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:value-of select="$daneOsoby/oso:Imie"/>
            </div>
        </div>
        <div class="row pb-3">
            <div class="du-col-5 du-inline pl-15">Nazwisko</div>
            <div class="du-col-7 du-bold du-inline">
                <xsl:value-of select="$daneOsoby/oso:Nazwisko"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="DaneOsobyPrawnej">
        <xsl:param name="daneOsoby"/>
        <div class="row pb-3">
            <div class="du-col-5 du-inline  pl-15">Nazwa podmiotu</div>
            <div class="du-col-7 du-bold du-inline">
                <xsl:value-of select="$daneOsoby/wnio:NazwaPodmiotu"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="DaneAdresata">
        <xsl:param name="daneAdresata" select="wnio:TrescDokumentu/wnio:DaneAdresata"/>
        <div class="du-margin-top-15 du-bold pb-8">Adresat</div>
        <div class="du-col-5 du-inline pb-3">Adres do e-doręczeń adresata</div>
        <div class="du-col-7 du-inline du-bold pb-3">
            <xsl:value-of select="$daneAdresata/wnio:AdresEDoreczen"/>
        </div>
        <div class="du-col-12 du-no-mt du-margin-bottom-15 pb-3">Dane adresata
            <xsl:if test="$daneAdresata/wnio:StronaKorespondencji/wnio:Rodzaj = 'osoba fizyczna'">
                <xsl:call-template name="DaneOsobyFizycznej">
                    <xsl:with-param name="daneOsoby" select="$daneAdresata/wnio:StronaKorespondencji/wnio:OsobaFizyczna"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="$daneAdresata/wnio:StronaKorespondencji/wnio:Rodzaj = 'osoba prawna'">
                <xsl:call-template name="DaneOsobyPrawnej">
                    <xsl:with-param name="daneOsoby" select="$daneAdresata/wnio:StronaKorespondencji/wnio:OsobaPrawna"/>
                </xsl:call-template>
            </xsl:if>
        </div>
        <div class="du-col-12 du-no-mt du-margin-bottom-15">Dane użytkownika upoważnionego<br/>przez adresata
            <br/>
            <xsl:call-template name="DaneOsobyFizycznej">
                <xsl:with-param name="daneOsoby" select="$daneAdresata/wnio:UzytkownikUpowazniony"/>
            </xsl:call-template>
        </div>
        <br/>
    </xsl:template>

    <xsl:template name="DataWyslania">
        <xsl:param name="dataWyslania" select="wnio:TrescDokumentu/wnio:DataWyslania"/>
        <div class="du-margin-top-15 du-bold pb-8">Data wysłania</div>
        <div class="row pb-3">
            <div class="du-col-5 du-inline">Data nadania korespondencji przez nadawcę</div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:call-template name="FormatowanieDat">
                    <xsl:with-param name="dataWniosku" select="$dataWyslania/wnio:DataNadaniaPrzesylki"/>
                </xsl:call-template>
            </div>
        </div>
        <div class="row pb-3">
            <div class="du-col-5 du-inline">Data akceptacji nadania korespondencji<br/>przez dostawcę usługi e-Doręczenia
            </div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:call-template name="FormatowanieDat">
                    <xsl:with-param name="dataWniosku" select="$dataWyslania/wnio:DataAkceptacjiNadaniaPrzesylki"/>
                </xsl:call-template>
            </div>
        </div>
        <br/>
    </xsl:template>

    <xsl:template name="DataOdbioru">
        <xsl:param name="dataOdbioru" select="wnio:TrescDokumentu/wnio:DataOdbioru"/>
        <div class="du-margin-top-15 du-bold pb-8">Data Odbioru</div>
        <xsl:if test="$dataOdbioru/wnio:DataUdostepnieniaDoOdbioru !=''">
        <div class="row pb-3">
            <div class="du-col-5 du-inline">Data wpłynięcia korespondencji na adres do doręczeń</div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:call-template name="FormatowanieDat">
                    <xsl:with-param name="dataWniosku" select="$dataOdbioru/wnio:DataUdostepnieniaDoOdbioru"/>
                </xsl:call-template>
            </div>
        </div>
        </xsl:if>
        <div class="row pb-3">
            <div class="du-col-5 du-inline">Data odebrania korespondencji przez adresata</div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:call-template name="FormatowanieDat">
                    <xsl:with-param name="dataWniosku" select="$dataOdbioru/wnio:DataPrzekazaniaAdresatowi"/>
                </xsl:call-template>
            </div>
        </div>
        <br/>
    </xsl:template>

    <xsl:template name="DaneWiadomosci">
        <xsl:param name="daneWiadomosci" select="wnio:TrescDokumentu/wnio:DaneWiadomosci"/>
        <div class="du-margin-top-15 du-bold pb-8">Dane wiadomości</div>
        <div class="row pb-3">
            <div class="du-col-5 du-inline">Identyfikator dowodu będącego podstawą potwierdzenia</div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:value-of select="$daneWiadomosci/wnio:IdentyfikatorDowoduPotwierdzenia"/>
            </div>
        </div>
        <div class="row pb-3">
            <div class="du-col-5 du-inline">Identyfikator wiadomości</div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:value-of select="$daneWiadomosci/wnio:IdentyfikatorWiadomosci"/>
            </div>
        </div>
        <div class="row pb-3">
            <div class="du-col-5 du-inline">Informacje dodatkowe</div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:value-of select="$daneWiadomosci/wnio:InformacjeDodatkowe"/>
            </div>
        </div>
        <div class="row pb-3">
            <div class="du-col-5 du-inline">Podstawa prawna i tryb doręczenia</div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:value-of select="$daneWiadomosci/wnio:TrybDoreczenia"/>
            </div>
        </div>
        <br/>
    </xsl:template>

    <xsl:template name="DaneZalacznika">
        <xsl:param name="atrybutZalacznika"/>
        <xsl:if test="$atrybutZalacznika[@nazwaAtrybutu='IdZalacznika'] != ''">
            <div class="row pb-3">
                <div class="du-col-5 du-inline pl-15">ID załącznika</div>
                <div class="du-col-7 du-inline du-bold">
                    <xsl:value-of select="$atrybutZalacznika[@nazwaAtrybutu='IdZalacznika']/wnio:WartoscAtrybutu"/>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="$atrybutZalacznika[@nazwaAtrybutu='NazwaZalacznika'] != ''">
            <div class="row pb-3">
                <div class="du-col-5 du-inline pl-15">Nazwa Załącznika</div>
                <div class="du-col-7 du-inline du-bold">
                    <xsl:value-of select="$atrybutZalacznika[@nazwaAtrybutu='NazwaZalacznika']/wnio:WartoscAtrybutu"/>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="$atrybutZalacznika[@nazwaAtrybutu='RozmiarZalacznika'] != ''">
            <div class="row pb-3">
                <div class="du-col-5 du-inline pl-15">Rozmiar</div>
                <div class="du-col-7 du-inline du-bold">
                    <xsl:value-of select="$atrybutZalacznika[@nazwaAtrybutu='RozmiarZalacznika']/wnio:WartoscAtrybutu"/>
                </div>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="InformacjeZalaczniki">
        <xsl:param name="informacjeZalaczniki" select="wnio:TrescDokumentu/wnio:DaneZalaczniki"/>
        <div class="du-margin-top-15 du-bold pb-8">Informacje o załącznikach</div>
        <xsl:for-each select="$informacjeZalaczniki">
            <xsl:for-each select="wnio:DaneZalacznika">
                <div class="du-col-12 du-no-mt du-margin-bottom-15 pb-3"><xsl:value-of select="position()"/>.
                        <xsl:call-template name="DaneZalacznika">
                            <xsl:with-param name="atrybutZalacznika" select="wnio:AtrybutZalacznika"/>
                        </xsl:call-template>
                </div>
            </xsl:for-each>
        </xsl:for-each>
        <br/>
    </xsl:template>

    <xsl:template name="DanePodpisuWystawcy">
        <xsl:param name="atrybutPodpisu"/>
        <xsl:if test="$atrybutPodpisu[@nazwaAtrybutu='Wystawca'] != ''">
        <div class="row pb-3">
            <div class="du-col-5 du-inline pl-15">Wystawca</div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:value-of select="$atrybutPodpisu[@nazwaAtrybutu='Wystawca']/wnio:WartoscAtrybutu"/>
            </div>
        </div>
        </xsl:if>
        <xsl:if test="$atrybutPodpisu[@nazwaAtrybutu='WazneOd'] != ''">
            <div class="row pb-3">
                <div class="du-col-5 du-inline pl-15">Data ważności od</div>
                <div class="du-col-7 du-inline du-bold">
                    <xsl:value-of select="$atrybutPodpisu[@nazwaAtrybutu='WazneOd']/wnio:WartoscAtrybutu"/>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="$atrybutPodpisu[@nazwaAtrybutu='WazneDo'] != ''">
            <div class="row pb-3">
                <div class="du-col-5 du-inline pl-15">Data ważności do</div>
                <div class="du-col-7 du-inline du-bold">
                    <xsl:value-of select="$atrybutPodpisu[@nazwaAtrybutu='WazneOd']//wnio:WartoscAtrybutu"/>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="$atrybutPodpisu[@nazwaAtrybutu='DataPodpisania'] != ''">
            <div class="row pb-3">
                <div class="du-col-5 du-inline pl-15">Data podpisania dowodu</div>
                <div class="du-col-7 du-inline du-bold">
                    <xsl:value-of select="$atrybutPodpisu[@nazwaAtrybutu='DataPodpisania']//wnio:WartoscAtrybutu"/>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="$atrybutPodpisu[@nazwaAtrybutu='NrSeryjny'] != ''">
            <div class="row pb-3">
                <div class="du-col-5 du-inline pl-15">Nr seryjny</div>
                <div class="du-col-7 du-inline du-bold">
                    <xsl:value-of select="$atrybutPodpisu[@nazwaAtrybutu='NrSeryjny']/wnio:WartoscAtrybutu"/>
                </div>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="DaneUslugaNadawcy">
        <xsl:param name="daneUslugi" select="wnio:TrescDokumentu/wnio:DaneUslugiEDoreczenNadawcy"/>
        <div class="du-margin-top-15 du-bold pb-8">Usługa e-doręczenia nadawcy</div>
        <div class="row pb-3">
            <div class="du-col-5 du-inline">Identyfikator usługi e-doręczenia,<br/>która zrealizowała
                wysłanie
            </div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:value-of select="$daneUslugi/wnio:IdentyfikatorUslugi"/>
            </div>
        </div>
        <div class="row pb-3">
            <div class="du-col-5 du-inline">Identyfikator polityki</div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:value-of select="$daneUslugi/wnio:IdentyfikatorPolityki"/>
            </div>
        </div>
        <div class="du-col-12 du-no-mt du-margin-bottom-15 pb-3">Dane podpisu wystawcy<br/>potwierdzenia otrzymania
            <xsl:for-each select="$daneUslugi/wnio:DanePodpisuWystawcy">
                <xsl:call-template name="DanePodpisuWystawcy">
                    <xsl:with-param name="atrybutPodpisu" select="$daneUslugi/wnio:DanePodpisuWystawcy/wnio:AtrybutPodpisu"/>
                </xsl:call-template>
            </xsl:for-each>
        </div>
        <br/>
    </xsl:template>

    <xsl:template name="DaneUslugaAdresata">
        <xsl:param name="daneUslugi" select="wnio:TrescDokumentu/wnio:DaneUslugiEDoreczenAdresata"/>
        <div class="du-margin-top-15 du-bold pb-8">Usługa e-doręczenia adresata</div>
        <div class="row pb-3">
            <div class="du-col-5 du-inline">Identyfikator usługi e-doręczenia,<br/>która zrealizowała
                doręczenie
            </div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:value-of select="$daneUslugi/wnio:IdentyfikatorUslugi"/>
            </div>
        </div>
        <div class="row pb-3">
            <div class="du-col-5 du-inline">Identyfikator polityki</div>
            <div class="du-col-7 du-inline du-bold">
                <xsl:value-of select="$daneUslugi/wnio:IdentyfikatorPolityki"/>
            </div>
        </div>
        <div class="du-col-12 du-no-mt du-margin-bottom-15 pb-3">Dane podpisu wystawcy dowodu
            <xsl:for-each select="$daneUslugi/wnio:DanePodpisuWystawcy">
                <xsl:call-template name="DanePodpisuWystawcy">
                    <xsl:with-param name="atrybutPodpisu" select="$daneUslugi/wnio:DanePodpisuWystawcy/wnio:AtrybutPodpisu"/>
                </xsl:call-template>
            </xsl:for-each>
        </div>
        <br/>
    </xsl:template>

    <xsl:template name="FormatowanieDat">
        <xsl:param name="dataWniosku"/>
        <xsl:variable name="data">
            <xsl:value-of select="substring-before($dataWniosku,'T')"/>
        </xsl:variable>
        <xsl:variable name="czas">
            <xsl:value-of select="substring-after($dataWniosku,'T')"/>
        </xsl:variable>
        <date>
            <xsl:value-of select="$data"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$czas"/>
        </date>
    </xsl:template>

    <xsl:template name="Podpis">
        <section>
            <div class="du-col-12 du-right">
                <xsl:choose>
                    <xsl:when test="string-length(//wnio:Dokument/ds:Signature/ds:SignatureValue) &gt; 0">
                        <p class="du-bold du-line">Podpis elektroniczny</p>
                        <xsl:text>Dokument został podpisany elektronicznie. Użyj specjalnego oprogramowania, aby zweryfikować
                    podpis.
                </xsl:text>
                        <xsl:choose>
                            <xsl:when test="count(//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']) &gt; 1">
                                <br/>
                                <xsl:text>Daty złożenia podpisu:</xsl:text>
                                <xsl:for-each select="//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']">
                                    <xsl:value-of select="."/>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:when test="count(//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']) = 1">
                                <br/>
                                <xsl:text>Data złożenia podpisu:</xsl:text>
                                <xsl:for-each select="//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']">
                                    <xsl:value-of select="."/>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:when test="0 &gt;= count(//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime'])"/>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <br/>
                        <p class="du-bold du-line">Dokument nie zawiera podpisu</p>
                        <br/>
                    </xsl:otherwise>
                </xsl:choose>
                <br/>
            </div>
        </section>
    </xsl:template>


    <xsl:template name="styleCSS">
        <style type="text/css">
            .du-view .du-normal-text {
            font-weight: normal;
            }

            .du-view label {
            display: inline
            }

            .du-view article,
            .du-view footer,
            .du-view header,
            .du-view section {
            display: block;
            }

            .du-view div {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 15px;
            line-height: 135%;
            word-wrap: break-word;
            line-height: 150%;
            }

            .du-view,
            .du-view * {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            }

            /*style for tags*/

            .du-view {
            width: 100%;
            padding: 1%;
            margin: 25px;
            margin-top: 35px;
            line-height: 130%;
            }

            .du-view h1,
            .du-view .h1 {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 2px;
            margin-top: 0;
            }

            .du-view h2,
            .du-view .h2,
            .du-view h4,
            .du-view .h4,
            .du-view h5,
            .du-view .h5,
            .du-view h6,
            .du-view .h6 {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 2px;
            text-transform: uppercase
            }

            .du-view h3,
            .du-view .h3 {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
            font-weight: bold;
            margin-top: 1%;
            }

            .du-view div {
            word-wrap: break-word;
            }

            .du-view div input {
            margin-top: 10px;
            margin-right: 8px;
            }

            /*grid and style for
            dotted*/

            .du-col-12-tablet {
            width: 16.66%;
            padding-right: 1.1%;
            }

            .du-col-12-dotted {
            width: 16.25%;
            padding-right: 1.1%;
            }

            .pl-15 {
            padding-left: 15px;
            }

            .pb-8 {
            padding-bottom: 8px;
            }

            .pb-3 {
            padding-bottom: 3px;
            }

            .du-col-7 {
            width: 58.33%;
            }

            .du-col-12 {
            width: 100%;
            }

            .du-col-12-dotted {
            width: 84.33%;
            }

            .du-col-12 {
            width: 100%;
            }

            /*other style*/

            div .du-no-mt {
            margin-top: 0;
            padding-left: 0;
            }

            .du-left {
            text-align: left;
            float: left;
            margin-top: 5px;
            }

            .du-inline {
            display: inline-block
            }

            div .du-left {
            text-align: left;
            float: left;
            margin-top: 5px;
            }

            .du-view h2 {
            margin-top: 10px;
            }

            div .du-right {
            margin-top: 1px;

            }

            .du-center {
            text-align: center;
            }

            .du-line {
            border-bottom: 2px solid #b9b9b9;
            padding-bottom: 10px;
            }

            .du-bold {
            font-weight: bold;
            }

            .row:after {
            content: "";
            display: table;
            clear: both;
            }

            .du-view {
            font-size: 12px;
            }

            .du-view h3,
            .du-view .h3 {
            font-size: 14px;
            font-weight: bold;
            margin-top: 1%;
            margin-bottom: 0;
            }

            .du-view div {
            line-height: 135%;
            }

            .du-view input {
            margin-top: 1%;
            margin-right: 3%;
            }

            .du-col-12 {
            width: 26.66%;
            }

            .du-col-12-tablet {
            width: 26.25%;
            }

            .du-col-12-dotted {
            width: 26.25%;
            }

            .du-col-5 {
            width: 36.66%;
            }

            .du-col-12 {
            width: 100%;
            }

            .du-col-12-dotted {
            width: 74.33%;
            }

            .du-view div {
            margin-top: 0px;
            }

            .footer-9 {
            font-size: 9px;
            }

            @media screen and (max-width: 650px) {
            .du-view div {
            margin-top: 3px;
            }

            .du-view input {
            margin-top: 1%;
            margin-right: 3%;
            }

            .du-col-12 {
            width: 100%;
            padding-right: 1.1%;
            }

            .du-col-12-tablet {
            width: 100%;
            padding-right: 1.1%;
            }

            .du-col-12-dotted {
            width: 99.25%;
            padding-right: 1.1%;
            }

            .du-right {
            text-align: left;
            float: left;
            }

            .du-col-12 {
            width: 100%;
            }

            .du-col-12-dotted {
            width: 99.25%;
            }
            }

            @media screen and (min-width: 651px) and (max-width: 1024px) {
            .du-col-12 {
            width: 100%;
            padding-right: 1.1%;
            }

            .du-col-12-dotted {
            width: 16.25%;
            padding-right: 1.1%;
            }

            .du-col-12-tablet {
            width: 16.25%;
            padding-right: 1.1%;


            .du-right {
            text-align: left
            }

            div .du-col-12 {
            width: 100%;
            }

            .du-col-12-dotted {
            width: 100%;
            }

            div .du-city-width {
            width: 100%;
            }

            .du-view div {
            margin-top: 3px;
            line-height: 100%;
            }
            }

            .du-margin-top-25 {
            margin-top: 25px
            }

            .du-margin-top-15 {
            margin-top: 15px
            }

        </style>
    </xsl:template>
</xsl:stylesheet>