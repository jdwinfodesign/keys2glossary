<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
	<xsl:output method="xml" 
		          doctype-public="urn:pubid:jdwinfodesign.com:doctypes:dita:dtd:map"
		          doctype-system="map.dtd" 
		          indent="yes"/>

	<!-- 
			<dtd publicId="urn:pubid:jdwinfodesign.com:doctypes:dita:dtd:map"
				   location="map.dtd"/>
	-->

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="reference">
		<xsl:element name="map">
			<xsl:element name="title">
				<xsl:attribute name="id">
					<!-- this value of id should probably be passed in as a param -->
					<xsl:text>glossary</xsl:text>
				</xsl:attribute>
				<!-- this value of title should probably be passed in as a param -->
				<xsl:text>Glossary</xsl:text>
			</xsl:element>
			<!-- 
			<topicref chunk="to-content" href="glossary/c_glossary.dita">
			-->
			<xsl:element name="topicref">
				<xsl:attribute name="chunk">
					<xsl:text>to-content</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:result-document method="xml" 
						doctype-public="urn:pubid:jdwinfodesign.com:doctypes:dita:dtd:concept"
						doctype-system="concept.dtd" 						
						indent="yes"
					  href="glossary/c_glossary.dita">
						<xsl:element name="concept">
							<xsl:attribute name="id">
								<xsl:text>c_glossary</xsl:text>
							</xsl:attribute>
							<title>Glossary</title>
							<shortdesc>The following terms are commonly used in <term conkeyref="productname_variables/ph_prodname"/></shortdesc>
						</xsl:element>
					</xsl:result-document>
					<xsl:text>glossary/c_glossary.dita</xsl:text>
				</xsl:attribute>
				<xsl:apply-templates select="//table"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="table">
		<xsl:for-each select="//tbody/row">
			<xsl:variable name="glossentryKeys">
				<xsl:value-of select="concat('g_',entry[2]//term/[substring-after(@id,'ph_')])"/>
			</xsl:variable>
			<xsl:element name="glossref">
				<xsl:attribute name="keys">
					<xsl:value-of select="$glossentryKeys"/>
				</xsl:attribute>
				<xsl:attribute name="href">
					<!-- Result document for child glossrefs/glossentries -->
					<xsl:result-document method="xml" 
						doctype-public="-//OASIS//DTD DITA Glossary//EN"
						doctype-system="glossary.dtd" 						
						indent="yes"
						href="{concat('glossary/',$glossentryKeys,'.dita')}">
						<xsl:element name="glossentry">
							<xsl:attribute name="id">
								<xsl:value-of select="$glossentryKeys"/>
							</xsl:attribute>
							<glossterm>
								<xsl:value-of select="entry[2]//term"/>
							</glossterm>
							<glossdef>
								<xsl:value-of select="entry[1]//ph"/>
							</glossdef>
						</xsl:element>
					</xsl:result-document>
					<!--  -->
					<xsl:value-of select="concat('glossary/',$glossentryKeys,'.dita')"/>
				</xsl:attribute>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
