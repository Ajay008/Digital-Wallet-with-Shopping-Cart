

function add(){
    if(selected<=avail-1)
    {
        selected++;
        document.getElementById("itemQuantity").innerHTML=selected;
        
        if(selected==avail)
            document.getElementById("addButton").disabled = true;
        if(selected==1)
            document.getElementById("removeButton").disabled = false;
    }
}


function remove(){
    if(selected>=1)
    { 
        selected--;
        document.getElementById("itemQuantity").innerHTML=selected;
        
        if(selected==0)
            document.getElementById("removeButton").disabled = true;
        if(selected==avail-1)
            document.getElementById("addButton").disabled = false;
    }
}


function addToCart(){

    var item = window.location.href;
    item = item.substring(item.lastIndexOf('/')+1,item.lastIndexOf('.'));

    console.log(item);
    var link = "addToCart.jsp" + "?"+item+"="+selected;
    $("#itemQuantity").load(link);
    
    //window.location.assign("addToCart.jsp" + "?"+item+"="+selected);
}





