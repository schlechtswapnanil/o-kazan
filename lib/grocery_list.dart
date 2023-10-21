import 'package:text_to_speech/text_to_speech.dart';

List <String> glist =[];
TextToSpeech tts= TextToSpeech();
addItem(String item)
{
  int i=0;
 
  while(i<glist.length) {
    if (glist[i] == item) {
      tts.speak('$item is already there in your cart');
      return;
    }
     glist.add(item);
  }
  tts.speak('Successfully added $item to your list. Your List now has $glist');
}

String removeItem(String item)
{
  String a='';
  if(glist.isEmpty) {
    a='Are you kidding me? Your Grocery List is Empty';
  }
  else
    {
      int i=0;
      while(i<glist.length)
        {
          if (glist[i]==item)
            {
              glist.removeAt(i);
              a='Removed $item successfully';
            }
          else
            {
              a='Sorry, Couldn\'t find $item in your list';
            }
        }
    }
  return a;

}