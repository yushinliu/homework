package xslt;

import java.io.File;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class Task24 {
	public static void main(String[] args) throws Exception {
		if (args.length != 2) {
			System.out
					.println("Please invoke this program providing two params: "
							+ "(1) the URL (or relative file-system location) of the XSLT stylesheet and "
							+ "(2) the URL (or relative file-system location) of the XML document to transform");
			return;
		}

		File xsltFile = new File(args[0]);
		File xmlDocument = new File(args[1]);

		TransformerFactory xformFactory = TransformerFactory.newInstance();
		Transformer transformer = xformFactory.newTransformer(new StreamSource(
				xsltFile));
		transformer.transform(new StreamSource(xmlDocument), new StreamResult(
				System.out));
	}
}
