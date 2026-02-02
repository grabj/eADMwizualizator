<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wnio="http://crd.gov.pl/wzor/2020/05/06/9378/" xmlns:meta="http://crd.gov.pl/xml/schematy/meta/2009/11/16/" xmlns:str="http://crd.gov.pl/xml/schematy/struktura/2009/11/16/" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:adr="http://crd.gov.pl/xml/schematy/adres/2009/11/09/" xmlns:oso="http://crd.gov.pl/xml/schematy/osoba/2009/11/16/" xmlns:inst="http://crd.gov.pl/xml/schematy/instytucja/2009/11/16/" version="1.0">
    <xsl:template match="/">
        <html>

        <head>
            <title>
                <xsl:value-of select="wnio:Dokument/wnio:DaneDokumentu/str:Naglowek/str:NazwaDokumentu"/>
            </title>
            <style>
    @page {
                size: A4;
                margin: 10mm 8mm;
            }
    
            @media print {
    
                html, body {
                    -webkit-print-color-adjust: exact;
                    width: 210mm;
                    height: 297mm;
                }
    
                .form-group:not(.allow-page-break), td, .section-header, .subsection-header {
                    page-break-inside: avoid;
                }
    
                table tbody tr td:before,
                table tbody tr td:after {
                    content: "";
                    height: 0px;
                    display: block;
                }
    
            }
    
            html, #main-container {
                font-family: sans-serif;
                font-size: 14px;
                color: #212529;
                max-width: 1920px;
            }
    
            .text-align-right {
                text-align: right;
            }
    
            .float-left {
                float: left;
            }
            .float-right {
                float: right;
            }
            .clear {
                clear: both;
            }
    
            .text-center {
                text-align: center;
            }
    
            .font-weight-bold {
                font-weight: 700;
            }
    
            h1 {
                font-size: 1.15rem;
            }
    
            h2 {
                font-size: 1rem;
                text-transform: uppercase;
                margin: 0;
                padding: 0;
            }
    
            h3 {
                font-size: 1rem;
                text-transform: uppercase;
                color: #006B9C;
                font-weight: 400;
            }
    
            .section-content p:first-child {
                margin-top: 0;
            }
    
            img#logo {
                width: 300px;
                height: 53px;
            }
    
            /*===== FORM GROUP =====*/
            .form-group {
                padding: 6px 0;
            }
    
            tr:first-child &gt; td &gt; .form-group:first-child {
                padding-top: 0;
            }
            tr:last-child &gt; td &gt; .form-group:last-child {
                padding-bottom: 0;
            }
            td &gt; table {
                margin-top: 6px;
                margin-bottom: 6px;
            }
    
            .form-group.bordered {
                border-top: 1px solid #DBDBDB;
                border-bottom: 1px solid #DBDBDB;
                margin-top: 8px;
                margin-bottom: 8px;
            }
    
            .form-group label {
                font-size: 0.75rem;
                text-transform: uppercase;
                color: #636363;
                font-weight: 700;
                display: block;
                margin-bottom: 2px;
            }
    
            .form-group &gt; div {
                color: #007CB5;
            }
    
            .form-group &gt; div pre {
                font-family: sans-serif;
                margin: 0;
                white-space: pre-wrap;
                white-space: -moz-pre-wrap;
                white-space: -pre-wrap;
                white-space: -o-pre-wrap;
                word-wrap: break-word;
            }
    
            .empty {
                color: #DBDBDB;
            }
    
            /*===== CHECKBOX =====*/
            .checkbox {
                position: relative;
                min-height: 18px;
            }
            .checkbox + .checkbox {
                margin-top: 5px;
            }
            .checkbox .check {
                position: absolute;
                top: 0;
                left: 0;
            }
            .checkbox label {
                margin: 0;
                margin-left: 22px;
                position: relative;
                top: 3px;
                text-transform: none;
                color: #1F4D72;
            }
    
            /*===== SECTION =====*/
            .section {
                display: block;
                margin-bottom: 16px;
            }
    
            .section-header {
                border: 1px solid #E2E2E2;
                margin: 0;
                border-radius: 0;
                background: #F5F5F5;
                line-height: 1;
                padding: 16px 16px;
            }
    
            .section-content {
                border: 1px solid #E2E2E2;
                border-top: 0;
                padding: 16px;
            }
    
            .section-content table, .section-content table tr {
                width: 100%;
            }
    
            .section-content table.single-info .form-group {
                padding: 0;
            }
    
            /*===== subSECTION =====*/
            .subsection-header.multiple {
                position: relative
            }
    
            .subsection + .subsection {
                margin-top: 12px;
            }
    
            .subsection-header {
                margin-bottom: 8px;
            }
    
            .subsection-header.multiple .number {
                background: #007CB5;
                color: #FFFFFF;
                position: absolute;
                top: 0;
                left: 0;
                min-width: 40px;
                width: 40px;
                padding: 0 8px;
                height: 40px;
                line-height: 40px;
                text-align: center;
                vertical-align: middle;
            }
    
            .subsection-header.multiple div:not(.number) {
                margin-left: 40px;
            }
    
            .subsection-header.multiple h3 {
                text-align: left;
                background: #f5f5f5;
                line-height: 40px;
                padding: 0 16px;
                text-transform: uppercase;
                margin: 0;
            }
    
            .subsection-content table tr {
                width: 100%;
            }
    
            /*===== TABLES =====*/
            table {
                font-size: inherit
            }
    
            table td {
                font-size: inherit;
                padding: 0;
            }
    
            table.grid-table {
                width: 100%;
                table-layout: fixed;
                border-collapse: collapse;
                border-spacing: 0;
            }
    
            table.grid-table col {
                width: 8.3333%;
            }
    
            table.table-bordered {
                table-layout: auto;
                width: 100%;
                min-width: 100%;
                border-collapse: collapse;
                border-spacing: 0;
            }
    
            table.table-bordered thead th {
                text-transform: uppercase;
                text-align: left;
                font-size: 0.85rem;
                font-weight: 700;
                line-height: 1.15em;
                color: #1F4D72;
                border-top: none;
                border-bottom: none;
                border-left: 1px solid #E2E2E2;
                background-color: #EAECEF;
                height: 40px;
                padding: 10px 15px;
            }
    
            table.table-bordered td {
                overflow-wrap: break-word;
                border: none;
                border-left: 1px solid #E2E2E2;
                border-bottom: 1px solid #E2E2E2;
                padding: 10px 15px;
                height: 40px;
            }
    
            table.table-bordered td:last-child,
            table.table-bordered th:last-child {
                border-right: 1px solid #E2E2E2;
            }
    
            table.table-bordered thead tr th:first-child {
                width: 60px;
            }
    
            table.table-bordered thead tr th {
                border-bottom: 1px solid #E2E2E2;
                border-top: 1px solid #E2E2E2;
            }
    
            table.table-bordered tr td:first-child {
                font-weight: 700;
                text-align: center;
            }
    
            .attachments-table:not(:last-of-type) {
                margin-bottom: 20px;
            }
    
            /*===== NICE CLASSIFICATION TABLE =====*/
            .nice-classification {
            }
    
            .nice-classification tr.nice-classification-header {
            }
    
            .nice-classification tr.nice-classification-header td {
                border-top: 1px solid #E2E2E2;
                background-color: #EAECEF;
                text-transform: uppercase;
                text-align: left;
                font-size: 0.85rem;
                font-weight: 700;
                line-height: 1.15em;
                color: #1F4D72;
            }
    
            .nice-classification td.nice-classification-class-number {
                vertical-align: top;
                padding-top: 20px;
                width: 40px;
            }
    
            .single-term {
                padding: 5px;
                border: 1px dashed black;
                margin-right: 5px;
                margin-bottom: 5px;
                margin-top: 5px;
                display: inline-block;
                word-break: break-all;
            }
    
            .term-success {
                border-color: #55960A;
                background-color: rgba(100, 177, 12, 0.1);
            }
    
            .term-danger {
                border-color: #D8000B;
                background-color: rgba(191, 0, 10, 0.1);
            }
    
            .term-warning {
                border-color: #F19000;
                background-color: rgba(217, 130, 0, 0.1);
            }
    
            .term-rejected {
                border-color: #6A6A6A;
                background-color: rgba(82, 82, 82, 0.1);
            }
    
            /* ===== PODPISY ===== */
            .signed-document {
                text-align: center;
                font-size: 10px;
                font-family: sans-serif;
                line-height: 20px;
                margin-bottom: 20px;
    
                width: 30%;
                margin-left: 70%;
            }
    
            .signed-document ol {
                display: inline-block;
                margin: 0;
                padding: 0;
                padding-left: 1em;
            }
    
            .signed-document .a-sign {
                font-size: 7pt;
                font-weight: bold;
            }
    
            /* ===== INNE ===== */
    
            .header-section {
                font-size: 1em;
            }
    
            .section.pouczenia p {
                font-size: 1em;
                line-height: 1.2em;
                text-align: justify;
            }
    
            .section.pouczenia p:first-child {
                margin-top: 0;
            }
    
            .section.pouczenia p:last-child {
                margin-bottom: 0;
            }
    
            .audio-placeholder &gt; span, .video-placeholder &gt; span {
                position: relative;
                top: -35px;
                left: 10px;
            }
    
            hr {
                height: 1px;
                border: none;
                border-top: 1px solid #DBDBDB;
            }
    
            html {
                box-sizing: border-box;
            }
    
            *, *::before, *::after {
                box-sizing: inherit;
            }
    
            .section-pouczenia {
                font-size: 0.9em;
            }
            </style>
        </head>

        <body>
            <div id="main-container">
                <div class="header-section">
                    <img alt="Sygnet Urzędu Patentowego" id="logo" src="data:image/png;base64,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"/>
                    <div style="margin: 1em 0;">
                        <div class="float-left">
                            Identyfikator dokumentu:
                            <xsl:if test="wnio:Dokument/wnio:DaneDokumentu/str:Naglowek/meta:Identyfikator[@typIdentyfikatora='PUEUP-Korespondencja']">
                                <xsl:value-of select="wnio:Dokument/wnio:DaneDokumentu/str:Naglowek/meta:Identyfikator[@typIdentyfikatora='PUEUP-Korespondencja']/meta:Wartosc"/>
                            </xsl:if>
                            <xsl:if test="not(wnio:Dokument/wnio:DaneDokumentu/str:Naglowek/meta:Identyfikator[@typIdentyfikatora='PUEUP-Korespondencja']) and wnio:Dokument/wnio:DaneDokumentu/str:Naglowek">
                                <xsl:for-each select="wnio:Dokument/wnio:DaneDokumentu/str:Naglowek/meta:Identyfikator">
                                    <xsl:value-of select="meta:Wartosc"/>
                                    <xsl:if test="position() != last()">
                                        <xsl:text>,</xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                        </div>
                        <div class="text-align-right">
                            <xsl:if test="wnio:Dokument/wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/oso:Osoba[1]/adr:Adres/adr:Miejscowosc">
                                <xsl:value-of select="wnio:Dokument/wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/oso:Osoba[1]/adr:Adres/adr:Miejscowosc"/>
                                <xsl:text>,</xsl:text>
                            </xsl:if>
                            <xsl:value-of select="substring(wnio:Dokument/wnio:DaneDokumentu/meta:Data/meta:Czas,9,2)"/>
                            <xsl:text>.</xsl:text>
                            <xsl:value-of select="substring(wnio:Dokument/wnio:DaneDokumentu/meta:Data/meta:Czas,6,2)"/>
                            <xsl:text>.</xsl:text>
                            <xsl:value-of select="substring(wnio:Dokument/wnio:DaneDokumentu/meta:Data/meta:Czas,1,4)"/>
                            <xsl:text>r.</xsl:text>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                    <div>
                        <xsl:for-each select="wnio:Dokument/wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/oso:Osoba[1]">
                            <div>
                                <xsl:value-of select="concat(oso:Imie, ' ', oso:Nazwisko)"/>
                            </div>
                            <xsl:if test="adr:Adres">
                                <div>
                                    <xsl:value-of select="concat(adr:Adres/adr:Ulica, ' ', adr:Adres/adr:Budynek, '/', adr:Adres/adr:Lokal)"/>
                                </div>
                                <div>
                                    <xsl:value-of select="concat(adr:Adres/adr:KodPocztowy, ' ', adr:Adres/adr:Miejscowosc)"/>
                                </div>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                    <div>
                        Adres skrytki elektronicznej:
                        <xsl:value-of select="wnio:Dokument/wnio:DaneDokumentu/str:Nadawcy/meta:Podmiot/oso:Osoba/oso:IdOsoby/oso:InnyIdentyfikator/oso:WartoscIdentyfikatora"/>
                    </div>
                    <div class="text-align-right font-weight-bold">
                        <div>
                            <xsl:value-of select="wnio:Dokument/wnio:DaneDokumentu/str:Adresaci/meta:Podmiot/inst:Instytucja/inst:NazwaInstytucji"/>
                        </div>
                        <div>
                            <xsl:value-of select="concat(wnio:Dokument/wnio:DaneDokumentu/str:Adresaci/meta:Podmiot/inst:Instytucja/adr:Adres/adr:Ulica, ' ', wnio:Dokument/wnio:DaneDokumentu/str:Adresaci/meta:Podmiot/inst:Instytucja/adr:Adres/adr:Budynek)"/>
                        </div>
                        <div>
                            <xsl:value-of select="concat(wnio:Dokument/wnio:DaneDokumentu/str:Adresaci/meta:Podmiot/inst:Instytucja/adr:Adres/adr:KodPocztowy, ' ', wnio:Dokument/wnio:DaneDokumentu/str:Adresaci/meta:Podmiot/inst:Instytucja/adr:Adres/adr:Miejscowosc)"/>
                        </div>
                        <div>
                            skr. poczt.
                            <xsl:value-of select="wnio:Dokument/wnio:DaneDokumentu/str:Adresaci/meta:Podmiot/inst:Instytucja/adr:Adres/adr:SkrytkaPocztowa"/>
                        </div>
                    </div>
                    <div>
                        <xsl:if test="wnio:Dokument/wnio:TrescDokumentu/wnio:NaszZnak/wnio:Numer != ''">
                            <div>
                                Nasz znak:
                                <xsl:value-of select="wnio:Dokument/wnio:TrescDokumentu/wnio:NaszZnak/wnio:Numer"/>
                            </div>
                        </xsl:if>
                    </div>
                    <div class="font-weight-bold text-center">
                        <h1><xsl:value-of select="wnio:Dokument/wnio:DaneDokumentu/str:Naglowek/str:NazwaDokumentu"/></h1>
                    </div>
                </div>
            </div>
            <xsl:if test="wnio:Dokument/wnio:TrescDokumentu/wnio:NrZgloszenia/node()">
                <div class="section section-nr_zgloszenia">
                    <div class="section-header">
                        <h2>Numer zgłoszenia</h2>
                    </div>
                    <div class="section-content">
                        <xsl:if test="wnio:Dokument/wnio:TrescDokumentu/wnio:NrZgloszenia/node()">
                            <table class="fields-and-values grid-table">
                                <colgroup>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                </colgroup>
                                <tbody>
                                    <xsl:if test="'true'">
                                        <tr>
                                            <td colspan="4" rowspan="1">
                                                <div class="form-group ">
                                                    <label>Numer zgłoszenia</label>
                                                    <div>
                                                        <xsl:choose>
                                                            <xsl:when test="wnio:Dokument/wnio:TrescDokumentu/wnio:NrZgloszenia/wnio:NrZgloszenia != ''">
                                                                <xsl:value-of select="wnio:Dokument/wnio:TrescDokumentu/wnio:NrZgloszenia/wnio:NrZgloszenia"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <span class="empty">brak danych</span>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </div>
                                                </div>
                                            </td>
                                            <td colspan="8" rowspan="1">
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </xsl:if>
                    </div>
                </div>
            </xsl:if>
            <xsl:if test="wnio:Dokument/wnio:TrescDokumentu/wnio:Wnioskodawca/node()">
                <div class="section section-wnioskodawca">
                    <div class="section-header">
                        <h2>Wnioskodawca</h2>
                    </div>
                    <div class="section-content">
                        <xsl:for-each select="wnio:Dokument/wnio:TrescDokumentu/wnio:Wnioskodawca">
                            <div class="subsection">
                                <div class="subsection-header multiple">
                                    <div class="number">
                                        <xsl:value-of select="position()"/>.
                                    </div>
                                    <div>
                                        <h3>Wnioskodawca</h3>
                                    </div>
                                </div>
                                <div class="subsection-content">
                                    <xsl:if test="node()">
                                        <table class="fields-and-values grid-table">
                                            <colgroup>
                                                <col span="1" width="8,333333333%"/>
                                                <col span="1" width="8,333333333%"/>
                                                <col span="1" width="8,333333333%"/>
                                                <col span="1" width="8,333333333%"/>
                                                <col span="1" width="8,333333333%"/>
                                                <col span="1" width="8,333333333%"/>
                                                <col span="1" width="8,333333333%"/>
                                                <col span="1" width="8,333333333%"/>
                                                <col span="1" width="8,333333333%"/>
                                                <col span="1" width="8,333333333%"/>
                                                <col span="1" width="8,333333333%"/>
                                                <col span="1" width="8,333333333%"/>
                                            </colgroup>
                                            <tbody>
                                                <xsl:if test="'true'">
                                                    <tr>
                                                        <td colspan="4" rowspan="1">
                                                            <div class="form-group ">
                                                                <label>Rodzaj wnioskodawcy</label>
                                                                <div>
                                                                    <xsl:choose>
                                                                        <xsl:when test="wnio:RodzajOsoby != ''">
                                                                            <xsl:value-of select="wnio:RodzajOsoby"/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <span class="empty">brak danych</span>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td colspan="8" rowspan="1">
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="wnio:RodzajOsoby/@kod != '' and wnio:RodzajOsoby/@kod ='osoba_fizyczna'">
                                                    <tr>
                                                        <td colspan="4" rowspan="1">
                                                            <div class="form-group ">
                                                                <label>Imię</label>
                                                                <div>
                                                                    <xsl:choose>
                                                                        <xsl:when test="wnio:Imie != ''">
                                                                            <xsl:value-of select="wnio:Imie"/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <span class="empty">brak danych</span>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td colspan="4" rowspan="1">
                                                            <div class="form-group ">
                                                                <label>Nazwisko</label>
                                                                <div>
                                                                    <xsl:choose>
                                                                        <xsl:when test="wnio:Nazwisko != ''">
                                                                            <xsl:value-of select="wnio:Nazwisko"/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <span class="empty">brak danych</span>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td colspan="4" rowspan="1">
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="wnio:RodzajOsoby/@kod != '' and wnio:RodzajOsoby/@kod ='osoba_fizyczna'">
                                                    <tr>
                                                        <td colspan="12" rowspan="1">
                                                            <div class="form-group ">
                                                                <label>Nazwa</label>
                                                                <div>
                                                                    <xsl:choose>
                                                                        <xsl:when test="wnio:NazwaOsoby != ''">
                                                                            <pre><xsl:value-of select="wnio:NazwaOsoby"/></pre>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <span class="empty">brak danych</span>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="wnio:RodzajOsoby/@kod != '' and wnio:RodzajOsoby/@kod = 'osoba_prawna'">
                                                    <tr>
                                                        <td colspan="12" rowspan="1">
                                                            <div class="form-group ">
                                                                <label>Nazwa</label>
                                                                <div>
                                                                    <xsl:choose>
                                                                        <xsl:when test="wnio:NazwaOsoby != ''">
                                                                            <pre><xsl:value-of select="wnio:NazwaOsoby"/></pre>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <span class="empty">brak danych</span>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="wnio:RodzajOsoby/@kod != '' and wnio:RodzajOsoby/@kod ='spolka_cywilna'">
                                                    <tr>
                                                        <td colspan="12" rowspan="1">
                                                            <div class="form-group ">
                                                                <label>Nazwa</label>
                                                                <div>
                                                                    <xsl:choose>
                                                                        <xsl:when test="wnio:NazwaOsoby != ''">
                                                                            <pre><xsl:value-of select="wnio:NazwaOsoby"/></pre>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <span class="empty">brak danych</span>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="wnio:RodzajOsoby/@kod != ''">
                                                    <tr>
                                                        <td colspan="12" rowspan="1">
                                                            <xsl:if test="wnio:Adres/node()">
                                                                <table class="fields-and-values grid-table">
                                                                    <colgroup>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                    </colgroup>
                                                                    <tbody>
                                                                        <xsl:if test="'true'">
                                                                            <tr>
                                                                                <td colspan="4" rowspan="1">
                                                                                    <div class="form-group ">
                                                                                        <label>Ulica</label>
                                                                                        <div>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="wnio:Adres/wnio:Ulica != ''">
                                                                                                    <xsl:value-of select="wnio:Adres/wnio:Ulica"/>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <span class="empty">brak danych</span>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td colspan="4" rowspan="1">
                                                                                    <div class="form-group ">
                                                                                        <label>Nr budynku</label>
                                                                                        <div>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="wnio:Adres/wnio:Budynek != ''">
                                                                                                    <xsl:value-of select="wnio:Adres/wnio:Budynek"/>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <span class="empty">brak danych</span>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td colspan="4" rowspan="1">
                                                                                    <div class="form-group ">
                                                                                        <label>Nr lokalu</label>
                                                                                        <div>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="wnio:Adres/wnio:Lokal != ''">
                                                                                                    <xsl:value-of select="wnio:Adres/wnio:Lokal"/>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <span class="empty">brak danych</span>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="'true'">
                                                                            <tr>
                                                                                <td colspan="4" rowspan="1">
                                                                                    <div class="form-group ">
                                                                                        <label>Miejscowość</label>
                                                                                        <div>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="wnio:Adres/wnio:Miejscowosc != ''">
                                                                                                    <xsl:value-of select="wnio:Adres/wnio:Miejscowosc"/>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <span class="empty">brak danych</span>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td colspan="4" rowspan="1">
                                                                                    <div class="form-group ">
                                                                                        <label>Poczta</label>
                                                                                        <div>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="wnio:Adres/wnio:Poczta != ''">
                                                                                                    <xsl:value-of select="wnio:Adres/wnio:Poczta"/>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <span class="empty">brak danych</span>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td colspan="4" rowspan="1">
                                                                                    <div class="form-group ">
                                                                                        <label>Kraj</label>
                                                                                        <div>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="wnio:Adres/wnio:Kraj != ''">
                                                                                                    <xsl:value-of select="wnio:Adres/wnio:Kraj"/>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <span class="empty">brak danych</span>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="'true'">
                                                                            <tr>
                                                                                <td colspan="4" rowspan="1">
                                                                                    <div class="form-group ">
                                                                                        <label>Kod pocztowy</label>
                                                                                        <div>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="wnio:Adres/wnio:KodPocztowy != ''">
                                                                                                    <xsl:value-of select="wnio:Adres/wnio:KodPocztowy"/>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <span class="empty">brak danych</span>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td colspan="8" rowspan="1">
                                                                                </td>
                                                                            </tr>
                                                                        </xsl:if>
                                                                    </tbody>
                                                                </table>
                                                            </xsl:if>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="wnio:RodzajOsoby/@kod != ''">
                                                    <tr>
                                                        <td colspan="12" rowspan="1">
                                                            <xsl:if test="wnio:DaneKontaktowe/node()">
                                                                <table class="fields-and-values grid-table">
                                                                    <colgroup>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                    </colgroup>
                                                                    <tbody>
                                                                        <xsl:if test="'true'">
                                                                            <tr>
                                                                                <td colspan="4" rowspan="1">
                                                                                    <div class="form-group ">
                                                                                        <label>Nr telefonu</label>
                                                                                        <div>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="wnio:DaneKontaktowe/wnio:Telefon != ''">
                                                                                                    <xsl:value-of select="wnio:DaneKontaktowe/wnio:Telefon"/>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <span class="empty">brak danych</span>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td colspan="4" rowspan="1">
                                                                                    <div class="form-group ">
                                                                                        <label>E-mail</label>
                                                                                        <div>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="wnio:DaneKontaktowe/wnio:Email != ''">
                                                                                                    <xsl:value-of select="wnio:DaneKontaktowe/wnio:Email"/>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <span class="empty">brak danych</span>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td colspan="4" rowspan="1">
                                                                                </td>
                                                                            </tr>
                                                                        </xsl:if>
                                                                    </tbody>
                                                                </table>
                                                            </xsl:if>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="wnio:RodzajOsoby/@kod != '' and wnio:RodzajOsoby/@kod = 'osoba_prawna'">
                                                    <tr>
                                                        <td colspan="12" rowspan="1">
                                                            <xsl:if test="wnio:NumeryStatystycznePodmiotu/node()">
                                                                <table class="fields-and-values grid-table">
                                                                    <colgroup>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                        <col span="1" width="8,333333333%"/>
                                                                    </colgroup>
                                                                    <tbody>
                                                                        <xsl:if test="'true'">
                                                                            <tr>
                                                                                <td colspan="4" rowspan="1">
                                                                                    <div class="form-group ">
                                                                                        <label>REGON</label>
                                                                                        <div>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="wnio:NumeryStatystycznePodmiotu/wnio:Regon != ''">
                                                                                                    <xsl:value-of select="wnio:NumeryStatystycznePodmiotu/wnio:Regon"/>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <span class="empty">brak danych</span>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td colspan="4" rowspan="1">
                                                                                    <div class="form-group ">
                                                                                        <label>KRS</label>
                                                                                        <div>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="wnio:NumeryStatystycznePodmiotu/wnio:Krs != ''">
                                                                                                    <xsl:value-of select="wnio:NumeryStatystycznePodmiotu/wnio:Krs"/>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <span class="empty">brak danych</span>
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td colspan="4" rowspan="1">
                                                                                </td>
                                                                            </tr>
                                                                        </xsl:if>
                                                                    </tbody>
                                                                </table>
                                                            </xsl:if>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                            </tbody>
                                        </table>
                                    </xsl:if>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                </div>
            </xsl:if>
            <xsl:if test="wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/node()">
                <div class="section section-tresc_zadania">
                    <div class="section-header">
                        <h2>Treść żądania</h2>
                    </div>
                    <div class="section-content">
                        <xsl:if test="wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/node()">
                            <table class="fields-and-values grid-table">
                                <colgroup>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                </colgroup>
                                <tbody>
                                    <xsl:if test="'true'">
                                        <tr>
                                            <td colspan="12" rowspan="1">
                                                Wnoszę o dokonanie ogłoszenia informacji o zgłoszeniu w terminie wcześniejszym
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="'true'">
                                        <tr>
                                            <td colspan="12" rowspan="1">
                                                <div class="form-group ">
                                                    <label>Tytuł zgłoszenia</label>
                                                    <div>
                                                        <xsl:choose>
                                                            <xsl:when test="wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:Tytul != ''">
                                                                <pre><xsl:value-of select="wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:Tytul"/></pre>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <span class="empty">brak danych</span>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="'true'">
                                        <tr>
                                            <td colspan="4" rowspan="1">
                                                <div class="form-group ">
                                                    <label>Numer zgłoszenia</label>
                                                    <div>
                                                        <xsl:choose>
                                                            <xsl:when test="wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:NrZgloszenia != ''">
                                                                <xsl:value-of select="wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:NrZgloszenia"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <span class="empty">brak danych</span>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </div>
                                                </div>
                                            </td>
                                            <td colspan="4" rowspan="1">
                                                <div class="form-group ">
                                                    <label>Data zgłoszenia</label>
                                                    <div>
                                                        <xsl:choose>
                                                            <xsl:when test="wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia != ''">
                                                                <xsl:value-of select="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,9,2)"/>
                                                                <xsl:text>
                                                                </xsl:text>
                                                                <xsl:choose>
                                                                    <xsl:when test="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,6,2) = '01'">sty</xsl:when>
                                                                    <xsl:when test="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,6,2) = '02'">lut</xsl:when>
                                                                    <xsl:when test="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,6,2) = '03'">mar</xsl:when>
                                                                    <xsl:when test="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,6,2) = '04'">kwi</xsl:when>
                                                                    <xsl:when test="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,6,2) = '05'">maj</xsl:when>
                                                                    <xsl:when test="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,6,2) = '06'">cze</xsl:when>
                                                                    <xsl:when test="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,6,2) = '07'">lip</xsl:when>
                                                                    <xsl:when test="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,6,2) = '08'">sie</xsl:when>
                                                                    <xsl:when test="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,6,2) = '09'">wrz</xsl:when>
                                                                    <xsl:when test="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,6,2) = '10'">paź</xsl:when>
                                                                    <xsl:when test="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,6,2) = '11'">lis</xsl:when>
                                                                    <xsl:when test="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,6,2) = '12'">gru</xsl:when>
                                                                </xsl:choose>
                                                                <xsl:text>
                                                                </xsl:text>
                                                                <xsl:value-of select="substring(wnio:Dokument/wnio:TrescDokumentu/wnio:TrescZadania/wnio:DataZgloszenia,1,4)"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <span class="empty">brak danych</span>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </div>
                                                </div>
                                            </td>
                                            <td colspan="4" rowspan="1">
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </xsl:if>
                    </div>
                </div>
            </xsl:if>
            <xsl:if test="wnio:Dokument/wnio:TrescDokumentu/wnio:Zalaczniki/node()">
                <div class="section section-zalaczniki">
                    <div class="section-header">
                        <h2>Załączniki</h2>
                    </div>
                    <div class="section-content">
                        <xsl:if test="wnio:Dokument/wnio:TrescDokumentu/wnio:Zalaczniki/node()">
                            <table class="fields-and-values grid-table">
                                <colgroup>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                    <col span="1" width="8,333333333%"/>
                                </colgroup>
                                <tbody>
                                    <xsl:if test="'true'">
                                        <tr>
                                            <td colspan="12" rowspan="1">
                                                <div class="form-group allow-page-break">
                                                    <div>
                                                        <xsl:if test="wnio:Dokument/wnio:TrescDokumentu/wnio:Zalaczniki/wnio:ListaZalacznikow and wnio:Dokument/wnio:TrescDokumentu/wnio:Zalaczniki/wnio:ListaZalacznikow/wnio:Zalacznik">
                                                            <table class="table table-bordered attachments-table">
                                                                <thead>
                                                                    <tr>
                                                                        <th>L.p.</th>
                                                                        <th>Typ dokumentu</th>
                                                                        <th>Nazwa pliku</th>
                                                                        <th>Opis</th>
                                                                        <th>Rozmiar</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <xsl:for-each select="wnio:Dokument/wnio:TrescDokumentu/wnio:Zalaczniki/wnio:ListaZalacznikow/wnio:Zalacznik">
                                                                        <tr>
                                                                            <td>
                                                                                <xsl:value-of select="position()"/>
                                                                            </td>
                                                                            <td>
                                                                                <xsl:value-of select="wnio:TypDokumentu"/>
                                                                            </td>
                                                                            <td>
                                                                                <xsl:value-of select="wnio:Nazwa"/>
                                                                            </td>
                                                                            <td>
                                                                                <xsl:value-of select="wnio:Opis"/>
                                                                            </td>
                                                                            <td>
                                                                                <xsl:value-of select="wnio:Rozmiar"/>B</td>
                                                                        </tr>
                                                                    </xsl:for-each>
                                                                </tbody>
                                                            </table>
                                                        </xsl:if>
                                                        <xsl:if test="not(wnio:Dokument/wnio:TrescDokumentu/wnio:Zalaczniki/wnio:ListaZalacznikow) or not(wnio:Dokument/wnio:TrescDokumentu/wnio:Zalaczniki/wnio:ListaZalacznikow/wnio:Zalacznik)">
                                                            <span class="empty">brak danych</span>
                                                        </xsl:if>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="'true'">
                                        <tr>
                                            <td colspan="12" rowspan="1">
                                                <xsl:if test="wnio:Dokument/wnio:TrescDokumentu/wnio:Zalaczniki/wnio:PotwierdzamZgodnoscZOryginalem = 'true'">
                                                    <div class="form-group">
                                                        <div class="checkbox">
                                                            <img class="check" alt="zaznaczony checkbox" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABTElEQVQ4EWP8DwQMVAAsIDOevH7P4F02keHRu08kGSklwMuwpimDQVNekoER5CLt+HqGZx8+k2QITLGcEB/DxfkNDEwgAXINAemF+QJsEEiAUkCyQVxs4GDFsJckgyT5eRj29xYztCf6kW+QlAAPw4aWbAY1OXGGv3//EjYoyEKHYXJmCAMTIyNcMbIh09fvZ6hZtBUuB2NgeDjRy5bBRl+VgYuDjSF1wnIGkHfWt2QxqMqKM4AMqVqwGaYXhcYwKKZ9HsOa+nSGIAcTBhYWZgZNBWkGVRkxvIaATMQI7I/ffzKENM5kOH39PoOfjSFRhoAMwnARSBBsWMNMhsm54Qy3Hr1kaF25CySMF2A1CKTj049fDPHdi/FqRpbE8BqyJClssEHSgryk6EFRC8q0IAA2aHVDOgNMAEUVAQ7IAVs68sCqwMUIAfVESQMARJxhO7HHYjgAAAAASUVORK5CYII="/>
                                                            <label>Potwierdzam za zgodność z oryginałem wszystkie załączone dokumenty</label>
                                                        </div>
                                                    </div>
                                                </xsl:if>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </xsl:if>
                    </div>
                </div>
            </xsl:if>
            <div class="section section-pouczenia">
                <div class="section-header">
                    <h2>Pouczenia</h2>
                </div>
                <div class="section-content">
                    <table class="fields-and-values grid-table">
                        <colgroup>
                            <col span="1" width="8,333333333%"/>
                            <col span="1" width="8,333333333%"/>
                            <col span="1" width="8,333333333%"/>
                            <col span="1" width="8,333333333%"/>
                            <col span="1" width="8,333333333%"/>
                            <col span="1" width="8,333333333%"/>
                            <col span="1" width="8,333333333%"/>
                            <col span="1" width="8,333333333%"/>
                            <col span="1" width="8,333333333%"/>
                            <col span="1" width="8,333333333%"/>
                            <col span="1" width="8,333333333%"/>
                            <col span="1" width="8,333333333%"/>
                        </colgroup>
                        <tbody>
                            <xsl:if test="'true'">
                                <tr>
                                    <td colspan="12" rowspan="1">
                                        <strong>Klauzula informacyjna</strong>
                                        <br/>
                                        <br/>Zgodnie z art. 13 ust. 1 i 2 Rozporządzenia Parlamentu Europejskiego i Rady (UE) 2016/679 z dnia 27 kwietnia 2016 r. w sprawie ochrony osób fizycznych w związku z przetwarzaniem danych osobowych i w sprawie swobodnego przepływu takich danych oraz uchylenia dyrektywy 95/46/WE (dalej RODO) Urząd Patentowy Rzeczypospolitej Polskiej informuje, że:
                                        <br/>
                                        <br/>1. Administratorem Pani/Pana danych osobowych jest Urząd Patentowy Rzeczypospolitej Polskiej z siedzibą w Warszawie, adres: al. Niepodległości 188/192, 00-950 Warszawa, skrytka pocztowa 203;
                                        <br/>2. Inspektor Ochrony Danych, dane kontaktowe: adres: al. Niepodległości 188/192, 00-950 Warszawa, tel. bezpośredni (022) 579 00 25, fax (022) 579 00 01, e-mail: iod@uprp.pl;
                                        <br/>3. Pani/Pana dane osobowe przetwarzane będą w celu realizowania zadań Urzędu Patentowego RP określonych przepisami ustawy z dnia 30 czerwca 2000 r. Prawo własności przemysłowej.
                                        <br/>4. Podstawą prawną przetwarzania Pani/Pana danych osobowych jest ustawa z dnia 30 czerwca 2000 r. Prawo własności przemysłowej, rozporządzenia wykonawcze do ww. ustawy, umowy międzynarodowe oraz art. 6 ust. 1 lit. c RODO;
                                        <br/>5. Pani/Pana dane osobowe mogą być przekazywane do podmiotów publicznych na zasadach obowiązujących w przepisach prawa oraz organizacjom międzynarodowym i organom unijnym, zgodnie z obowiązującymi przepisami prawa i umowami międzynarodowymi, po upływie terminów zastrzeżonych dla nieujawniania informacji o zgłoszeniu;
                                        <br/>6. Pani/Pana dane osobowe będą przechowywane przez okres zgodny z zasadami archiwizacji dokumentów w Urzędzie Patentowym RP;
                                        <br/>7. Posiada Pani/Pan prawo żądania dostępu do treści swoich danych osobowych, prawo ich sprostowania oraz prawo do ograniczenia ich przetwarzania;
                                        <br/>8. Przysługuje Pani/Panu prawo wniesienia skargi do organu nadzorczego właściwego w zakresie ochrony danych osobowych gdy uzna Pani/Pan, że przetwarzanie Pani/Pana danych osobowych narusza przepisy RODO;
                                        <br/>9. Podanie przez Panią/Pana danych osobowych jest wymogiem ustawowym niezbędnym do dalszego procedowania przez Urząd Patentowy RP.
                                    </td>
                                </tr>
                            </xsl:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="signed-document">
                <xsl:choose>
                    <xsl:when test="string-length(//wnio:Dokument/ds:Signature/ds:SignatureValue) &gt; 0">
                        <xsl:text>Dokument został podpisany, aby go zweryfikować należy użyć oprogramowania do weryfikacji podpisu.</xsl:text>
                        <br/>
                        <xsl:choose>
                            <xsl:when test="count(//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']) &gt; 1">
                                <b><xsl:text>Daty złożenia podpisów:</xsl:text></b>
                            </xsl:when>
                            <xsl:when test="count(//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']) = 1">
                                <b><xsl:text>Data złożenia podpisu:</xsl:text></b>
                            </xsl:when>
                        </xsl:choose>
                        <div>
                            <xsl:for-each select="//wnio:Dokument/ds:Signature/ds:Object/descendant::*[local-name() = 'SigningTime']">
                                <xsl:value-of select="."/>
                                <br/>
                            </xsl:for-each>
                        </div>
                        <br/>
                        <span class="a-sign">Podpis elektroniczny</span>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Dokument nie zawiera podpisu elektronicznego.</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </body>

        </html>
    </xsl:template>
</xsl:stylesheet>