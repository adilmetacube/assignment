public class XMLparse{
    string XMLString;
    contact tempcont;
    List<Contact> contactList;
    
    public void parseXML(String XMLString ){
        contactList = new list<Contact>();
        //XMLString = '<?xml version="1.0" encoding="UTF-8"?><products><product><name>Xbox</name><code>XBO</code></product><product><name>Playstation</name><code>PS</code></product><product><name>Wii</name></product></products>';
        DOM.Document doc=new DOM.Document();
        try{
            doc.load(XMLString);
            DOM.XmlNode rootNode=doc.getRootElement();
            parseXML(rootNode);
            contactList.add(tempcont);
            insert contactList;
        }catch(exception e){
            system.debug(e.getMessage());
        }
    }
    
    private void parseXML(DOM.XMLNode node) {
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
        system.debug(node.getName());
            if(node.getName()=='contact'){
                if(tempcont!=null)
                    contactList.add(tempcont);
                tempcont = new contact();
            }
            if(node.getName()=='fname')
                tempcont.FirstName=node.getText().trim();
            if(node.getName()=='lname')
                tempcont.LastName=node.getText().trim();
        }
        for (Dom.XMLNode child: node.getChildElements()) {
            parseXML(child);
        }
    }
}
