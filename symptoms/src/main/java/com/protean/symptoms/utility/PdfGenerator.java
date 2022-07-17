package com.protean.symptoms.utility;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.itextpdf.io.font.FontConstants;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.draw.SolidLine;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.LineSeparator;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Text;
import com.itextpdf.layout.property.HorizontalAlignment;
import com.itextpdf.layout.property.TextAlignment;
import com.protean.symptoms.constants.ConsultationConstants;
import com.protean.symptoms.constants.ErrorConstants;
import com.protean.symptoms.exception.ConsultationServiceException;

@Component
public class PdfGenerator {
	
	private static final Logger logger = LoggerFactory.getLogger(PdfGenerator.class);
	
	@Value("${prescription.path}")
	private String prescriptionPath;

	@Value("${path.seperator}")
	private String pathSeperator;
	
	public String generatePrescriptionPDF(Map<String, String> details)
			throws IOException {
		PdfWriter writer = null;
		PdfDocument pdfDoc = null;
		Document document = null;
		
		try {
			logger.info("inside generateDefaultPrescriptionPDF");
			String path = prescriptionPath + pathSeperator;
			String drName = null;
			String ptName = null;
			DateTimeFormatter timeStampPattern = DateTimeFormatter.ofPattern("yyyyMMddHHmm"); 
			String formattedDate = timeStampPattern.format(java.time.LocalDateTime.now());
			if(details.get(ConsultationConstants.DRNAME.getValue()).contains(" ") || details.get(ConsultationConstants.PTNAME.getValue()).contains(" ") ) {
				 drName= details.get(ConsultationConstants.DRNAME.getValue()).trim().replaceAll("\\s+", "_");
				 ptName= details.get(ConsultationConstants.PTNAME.getValue()).trim().replaceAll("\\s+", "_");
			}
			else {
				 drName=details.get(ConsultationConstants.DRNAME.getValue());
				 ptName= details.get(ConsultationConstants.PTNAME.getValue());
			}
			
			String filePath = path +formattedDate+"_"+drName+"_"+ptName+".pdf";
			generateDirectory(path);
			boolean isfileDeleted = Files.deleteIfExists(Paths.get(filePath));
			logger.info("inside generateDefaultPrescriptionPDF : existing files deleted" + filePath +" ***** "+isfileDeleted);

			writer = new PdfWriter(filePath);
			pdfDoc = new PdfDocument(writer);
			document = new Document(pdfDoc);

			Paragraph para;
			
			// Doctor Name
			para = new Paragraph("Dr. " + details.get(ConsultationConstants.DRNAME.getValue()).toUpperCase());
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
		   // para.setVerticalAlignment(VerticalAlignment.MIDDLE);
			para.setFontSize(20);
			para.setMarginBottom(-5);
			para.setMarginLeft(50F);
			para.setTextAlignment(TextAlignment.CENTER);
			document.add(para);
			
			para = new Paragraph();
			document.add(para);
			
			// Doctor Mobile & Email.
			/*
			 * para = new Paragraph("Mobile No : " +
			 * details.get(ConsultationConstants.DRMOBILENO.getValue()) + "  Email ID : " +
			 * null != details.get(ConsultationConstants.DREMAILID.getValue()) ?
			 * details.get(ConsultationConstants.DREMAILID.getValue()) : ""); //
			 * para.setVerticalAlignment(VerticalAlignment.MIDDLE);
			 * para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			 * para.setFontSize(8); para.setMarginTop(-7); para.setMarginBottom(1);
			 * para.setMarginLeft(50F); para.setTextAlignment(TextAlignment.CENTER);
			 * document.add(para);
			 * 
			 * para = new Paragraph(); document.add(para);
			 */
			
			// Doctor MCI & SMC no.
			/*
			 * para = new Paragraph("MCI No : " +
			 * details.get(ConsultationConstants.DRMCINO.getValue()) + "  SMC No : " +
			 * details.get(ConsultationConstants.DRSMCNO.getValue())); //
			 * para.setVerticalAlignment(VerticalAlignment.TOP);
			 * para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			 * para.setFontSize(8); para.setMarginTop(-7); para.setMarginBottom(1);
			 * para.setMarginLeft(50F); para.setTextAlignment(TextAlignment.CENTER);
			 * document.add(para);
			 */

			// Line Seperator
			document.add(new LineSeparator(new SolidLine(2f)));

			// Date
			/*
			 * para = new Paragraph(ConsultationConstants.APPTDATE.getValue() + " : " +
			 * details.get(ConsultationConstants.APPTDATE.getValue()));
			 * para.setFont(PdfFontFactory.createFont(FontConstants.COURIER_BOLD));
			 * para.setMarginTop(2); para.setFontSize(10f); // para.setBold();
			 * para.setMarginLeft(410F); document.add(para);
			 */

			// Patient name.
			para = new Paragraph(ConsultationConstants.PTNAME.getValue() + " : "
					+ details.get(ConsultationConstants.PTNAME.getValue()));
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			para.setBold();
			para.setFontSize(16f);
			para.setMarginTop(3);
			document.add(para);

			// AppointmentId 
			para = new Paragraph(ConsultationConstants.APPTID.getValue() + ": "
					+ details.get(ConsultationConstants.APPTID.getValue()));
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
		    para.setFontSize(12f);
			para.setMarginTop(-6);
			para.setBold();
			document.add(para);
			
			//Age
			/*
			 * para = new Paragraph(ConsultationConstants.AGE.getValue() + " : " +
			 * details.get(ConsultationConstants.AGE.getValue()));
			 * para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			 * para.setFontSize(16f); para.setMarginTop(-6); para.setBold();
			 * document.add(para);
			 */
			
			//ABHA ID
			para = new Paragraph(ConsultationConstants.ABHAID.getValue()
					+ ": " + details.get(ConsultationConstants.ABHAID.getValue()));
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			para.setBold();
			para.setFontSize(12f);
			para.setMarginTop(6);
			document.add(para);
			
			//ABHA NUMBER
			para = new Paragraph(ConsultationConstants.ABHANUMBER.getValue()
					+ ": " + details.get(ConsultationConstants.ABHANUMBER.getValue()));
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			para.setBold();
			para.setFontSize(12f);
			para.setMarginTop(6);
			document.add(para);

			// Symptoms Heading
			para = new Paragraph(ConsultationConstants.SYMPTOMS.getValue() + " :");
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			para.setBold();
			para.setFontSize(14f);
			para.setMarginTop(6);
			document.add(para);
			// Chief Complain Details
			para = new Paragraph(null != details.get(ConsultationConstants.SYMPTOMS.getValue()) ? details.get(ConsultationConstants.SYMPTOMS.getValue()) : "");
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			para.setFontSize(12f);
			para.setMarginTop(-6);
			document.add(para);

			// Diagnosis Heading
			para = new Paragraph(ConsultationConstants.DIAGNOSIS.getValue() + " :");
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			para.setBold();
			para.setFontSize(14f);
			para.setMarginTop(6);
			document.add(para);
			// Diagnosis Details
			para = new Paragraph(null != details.get(ConsultationConstants.DIAGNOSIS.getValue()) ? details.get(ConsultationConstants.DIAGNOSIS.getValue()) : "");
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			para.setFontSize(12f);
			para.setMarginTop(-6);
			document.add(para);

			// Medicine Heading
			para = new Paragraph(ConsultationConstants.MEDICATION.getValue() + " :");
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			para.setBold();
			para.setFontSize(14f);
			para.setMarginTop(8);
			document.add(para);
			
			// Medicine Details
			para = new Paragraph(null != details.get(ConsultationConstants.MEDICATION.getValue()) ? details.get(ConsultationConstants.MEDICATION.getValue()).replace(":", " ") : "");
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			para.setFontSize(12f);
			para.setMarginTop(-6);
			para.setMarginBottom(5);
			document.add(para);
			// Medicine Details End

			// Advice Heading
			para = new Paragraph(ConsultationConstants.ADVICE.getValue() + " :");
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			para.setBold();
			para.setFontSize(14f);
			para.setMarginTop(8);
			document.add(para);

			// Advice Details
			para = new Paragraph(null != details.get(ConsultationConstants.ADVICE.getValue()) ? details.get(ConsultationConstants.ADVICE.getValue()) : "");
			para.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			para.setFontSize(12f);
			para.setMarginTop(-6);
			para.setMarginBottom(5);
			document.add(para);

			// Dr. confirmation
			para = new Paragraph();
			Text t1 = new Text(details.get(ConsultationConstants.DRNAME.getValue()));
			t1.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			t1.setFontSize(12F);
			Text t2 = new Text("\n(" + details.get(ConsultationConstants.DRSPECIALIZATION.getValue()) + ")");
			t2.setFont(PdfFontFactory.createFont(FontConstants.TIMES_ROMAN));
			t2.setFontSize(10F);
			t2.setHorizontalAlignment(HorizontalAlignment.CENTER);
			para.add(t1);
			para.add(t2);
			para.setMarginTop(15F);
			para.setMarginLeft(410F);
			para.setHorizontalAlignment(HorizontalAlignment.CENTER);

			document.add(para);
			document.close();
			pdfDoc.close();
			writer.close();
			logger.info("Returning from generateDefaultPrescriptionPDF()");
			return filePath;
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
			throw new ConsultationServiceException(ErrorConstants.ERROR_GENERATING_PDF.getCode(),ErrorConstants.ERROR_GENERATING_PDF.getMessage());
		} finally {
			document.close();
			pdfDoc.close();
			writer.close();
		}
	}
	
	private void generateDirectory(String path) {
		File directory = new File(path);
		if (!directory.exists()) {
			directory.mkdir();
		}
	}

}
