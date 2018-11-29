local NoteToExtended ChordToExtended NoteToExtendedWithTime ChordToExtendedWithTime NoteToExtendedTransposedUp ChordToExtendedTransposedUp NoteToExtendedTransposedDown ChordToExtendedTransposedDown TransposeExtendedNoteUp TransposeExtendedNoteDown ShiftUp ShiftDown GetTime SetDuration SetStretch SetDrone SetTranspose PartitionToTimedList GetFrequency GetHeigth in
   % See project statement for API details.
   %[Project] = {Link ['Project2018.ozf']}
   %Time = {Link ['x-oz://boot/Time']}.1.getReferenceTime
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
   % Translate a note to the extended notation.
   fun {NoteToExtended Note} %Transforme une note en extended note de durée 1
      case Note
      of Name#Octave then
	 note(name:Name octave:Octave sharp:true duration:1.0 instrument:none)
      [] note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then %% Gere le cas ou on envoie deja une extended note 
	 note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none)
      []silence(duration:Duration) then  %% gere le cas ou on envoie deja un silence extended note 
	 silence(duration:Duration)
      [] Atom then
	 case {AtomToString Atom}
	 of [115 105 108 101 110 99 101] then silence(duration:1.0) %Traduction de silence en String
	 [] [_] then
	    note(name:Atom octave:4 sharp:false duration:1.0 instrument:none)
	 [] [N O] then
	    note(name:{StringToAtom [N]}
		 octave:{StringToInt [O]}
		 sharp:false
		 duration:1.0
		 instrument: none)
	 end
      end
   end
   
   fun{ChordToExtended Chord}
      local Tail in
	 fun{Tail Chord Acc}
	    case Chord
	    of nil then Acc
	    [] H|T then
	       {Tail T Acc|{NoteToExtended H}} %% gere donc aussi le cas ou on appelle sur un chord deja extended 
	    end
	 end
	 {Tail Chord nil}
      end
   end
 
   fun{NoteToExtendedWithTime Note Factor} %Note to extended note with duration:Factor for the note
      case Note
      of Name#Octave then
	 note(name:Name octave:Octave sharp:true duration:Factor instrument:none)
      [] Atom then
	 case {AtomToString Atom}
	 of [115 105 108 101 110 99 101] then silence(duration:Factor) %Traduction de silence en String
	 [] [_] then
	    note(name:Atom octave:4 sharp:false duration:Factor instrument:none)
	 [] [N O] then
	    note(name:{StringToAtom [N]}
		 octave:{StringToInt [O]}
		 sharp:false
		 duration:Factor
		 instrument: none)
	 end
      end
   end
 
   fun{ChordToExtendedWithTime Chord Factor} %Chord to extended chord with duration:Factor for each note
      local Tail in
	 fun{Tail Chord Factor Acc}
	    case Chord
	    of nil then Acc
	    [] H|T then
	       {Tail T Factor Acc|{NoteToExtendedWithTime H Factor}}
	    end
	 end
	 {Tail Chord Factor nil}
      end
   end
 
   fun{NoteToExtendedTransposedUp Note}
      local E Z in
	 case Note
	 of Name#Octave then
	    if Name == g then note(name:a octave:Octave+1 sharp:false duration:1.0 instrument:none)
	    elseif Name == a then note(name:b octave:Octave sharp:false duration:1.0 instrument:none)
	    elseif Name == c then note(name:d octave:Octave sharp:false duration:1.0 instrument:none)
	    elseif Name == d then note(name:e octave:Octave sharp:false duration:1.0 instrument:none)
	    else note(name:g octave:Octave sharp:false duration:1.0 instrument:none)
	    end
	 [] Atom then
	    case {AtomToString Atom}
	    of [115 105 108 101 110 99 101] then silence(duration:1.0) %Traduction de silence en String
	    [] [S] then
	       case {StringToAtom [S]}
	       of a then note(name:a octave:4 sharp:true duration:1.0 instrument:none)
	       [] b then note(name:c octave:4 sharp:false duration:1.0 instrument:none)
	       [] c then note(name:c octave:4 sharp:true duration:1.0 instrument:none)
	       [] d then note(name:d octave:4 sharp:true duration:1.0 instrument:none)
	       [] e then note(name:f octave:4 sharp:false duration:1.0 instrument:none)
	       [] f then note(name:f octave:4 sharp:true duration:1.0 instrument:none)
	       else note(name:g octave:4 sharp:true duration:1.0 instrument:none)
	       end
	    [] [N O] then
	       E = {StringToAtom [N]}
	       Z = {StringToInt [O]}
	       case E
	       of a then note(name:a octave:Z sharp:true duration:1.0 instrument:none)
	       [] b then note(name:c octave:Z sharp:false duration:1.0 instrument:none)
	       [] c then note(name:c octave:Z sharp:true duration:1.0 instrument:none)
	       [] d then note(name:d octave:Z sharp:true duration:1.0 instrument:none)
	       [] e then note(name:f octave:Z sharp:false duration:1.0 instrument:none)
	       [] f then note(name:f octave:Z sharp:true duration:1.0 instrument:none)
	       else note(name:g octave:Z sharp:true duration:1.0 instrument:none)
	       end
	    end
	 end
      end
   end
 
   fun{ChordToExtendedTransposedUp Chord}
      local Tail in
	 fun{Tail Chord Acc}
	    case Chord
	    of nil then Acc
	    [] H|T then
	       {Tail T Acc|{NoteToExtendedTransposedUp H}}
	    end
	 end
	 {Tail Chord nil}
      end
   end
 
   fun{NoteToExtendedTransposedDown Note}
      local E Z in
	 case Note
	 of Name#Octave then
	    if Name == g then note(name:g octave:Octave sharp:false duration:1.0 instrument:none)
	    elseif Name == a then note(name:a octave:Octave sharp:false duration:1.0 instrument:none)
	    elseif Name == c then note(name:c octave:Octave sharp:false duration:1.0 instrument:none)
	    elseif Name == d then note(name:d octave:Octave sharp:false duration:1.0 instrument:none)
	    else note(name:f octave:Octave sharp:false duration:1.0 instrument:none)
	    end
	 [] Atom then
	    case {AtomToString Atom}
	    of [115 105 108 101 110 99 101] then silence(duration:1.0) %Traduction de silence en String
	    [] [S] then
	       case {StringToAtom [S]}
	       of a then note(name:g octave:3 sharp:true duration:1.0 instrument:none)
	       [] b then note(name:a octave:4 sharp:true duration:1.0 instrument:none)
	       [] c then note(name:b octave:4 sharp:false duration:1.0 instrument:none)
	       [] d then note(name:c octave:4 sharp:true duration:1.0 instrument:none)
	       [] e then note(name:d octave:4 sharp:true duration:1.0 instrument:none)
	       [] f then note(name:e octave:4 sharp:false duration:1.0 instrument:none)
	       else note(name:f octave:4 sharp:true duration:1.0 instrument:none)
	       end
	    [] [N O] then
	       E = {StringToAtom [N]}
	       Z = {StringToInt [O]}
	       case E
	       of a then note(name:g octave:Z-1 sharp:true duration:1.0 instrument:none)
	       [] b then note(name:a octave:Z sharp:true duration:1.0 instrument:none)
	       [] c then note(name:b octave:Z sharp:false duration:1.0 instrument:none)
	       [] d then note(name:c octave:Z sharp:true duration:1.0 instrument:none)
	       [] e then note(name:d octave:Z sharp:true duration:1.0 instrument:none)
	       [] f then note(name:e octave:Z sharp:false duration:1.0 instrument:none)
	       else note(name:f octave:Z sharp:true duration:1.0 instrument:none)
	       end
	    end
	 end
      end
   end
 
   fun{ChordToExtendedTransposedDown Chord}
      local Tail in
	 fun{Tail Chord Acc}
	    case Chord
	    of nil then Acc
	    [] H|T then
	       {Tail T Acc|{NoteToExtendedTransposedDown H}}
	    end
	 end
	 {Tail Chord nil}
      end
   end
 
   fun{TransposeExtendedNoteUp ExtendedNote}
      case ExtendedNote
      of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
	 if Boolean == true then
	    if Name == g then note(name:a octave:Octave+1 sharp:false duration:Duration instrument:none)
	    elseif Name == a then note(name:b octave:Octave sharp:false duration:Duration instrument:none)
	    elseif Name == c then note(name:d octave:Octave sharp:false duration:Duration instrument:none)
	    elseif Name == d then note(name:e octave:Octave sharp:false duration:Duration instrument:none)
	    else note(name:g octave:Octave sharp:false duration:Duration instrument:none)
	    end
	 else
	    if Name == a then note(name:a octave:Octave sharp:true duration:Duration instrument:none)
	    elseif Name == b then note(name:c octave:Octave sharp:false duration:Duration instrument:none)
	    elseif Name == c then note(name:c octave:Octave sharp:true duration:Duration instrument:none)
	    elseif Name == d then note(name:d octave:Octave sharp:true duration:Duration instrument:none)
	    elseif Name == e then note(name:f octave:Octave sharp:false duration:Duration instrument:none)
	    elseif Name == f then note(name:f octave:Octave sharp:true duration:Duration instrument:none)
	    else note(name:g octave:Octave sharp:true duration:Duration instrument:none)
	    end
	 end
      else
	 ExtendedNote
      end
   end
 
   fun{TransposeExtendedNoteDown ExtendedNote}
      case ExtendedNote
      of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
	 if Boolean == true then
	    if Name == g then note(name:g octave:Octave sharp:false duration:Duration instrument:none)
	    elseif Name == a then note(name:a octave:Octave sharp:false duration:Duration instrument:none)
	    elseif Name == c then note(name:c octave:Octave sharp:false duration:Duration instrument:none)
	    elseif Name == d then note(name:d octave:Octave sharp:false duration:Duration instrument:none)
	    else note(name:f octave:Octave sharp:false duration:Duration instrument:none)
	    end
	 else
	    if Name == a then note(name:g octave:Octave-1 sharp:true duration:Duration instrument:none)
	    elseif Name == b then note(name:a octave:Octave sharp:true duration:Duration instrument:none)
	    elseif Name == c then note(name:b octave:Octave sharp:false duration:Duration instrument:none)
	    elseif Name == d then note(name:c octave:Octave sharp:true duration:Duration instrument:none)
	    elseif Name == e then note(name:d octave:Octave sharp:true duration:Duration instrument:none)
	    elseif Name == f then note(name:e octave:Octave sharp:false duration:Duration instrument:none)
	    else note(name:f octave:Octave sharp:true duration:Duration instrument:none)
	    end
	 end
      else
	 ExtendedNote
      end
   end
 
   fun{ShiftUp Partition}
      local TailShiftUp in
	 fun{TailShiftUp Partition Acc}
	    case Partition
	    of nil then Acc
	    [] H|T then
	       case H
	       of Note|Chord then
		  case Note
		  of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		     {TailShiftUp T Acc|{TailShiftUp Chord Acc|{TransposeExtendedNoteUp Note}}}
		  else
		     {TailShiftUp T Acc|{ChordToExtendedTransposedUp H}}
		  end
	       []note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		  {TailShiftUp T Acc|{TransposeExtendedNoteUp H}}
	       []duration(seconds:DurationBis PartitionBis) then
		  {TailShiftUp T Acc|{SetDuration DurationBis PartitionBis}}
	       []stretch(factor:FactorBis PartitionBis) then
		  {TailShiftUp T Acc|{SetStretch FactorBis PartitionBis}}
	       []drone(note:NoteOrChord amount:Amount) then
		  {TailShiftUp T Acc|{SetDrone NoteOrChord Amount}}
	       []transpose(semitones:Integer PartitionBis) then
		  {TailShiftUp T Acc|{SetTranspose Integer PartitionBis}}
	       else
		  {TailShiftUp T Acc|{NoteToExtendedTransposedUp H}}
	       end
	    end
	 end
	 {TailShiftUp Partition nil}
      end
   end
 
   fun{ShiftDown Partition}
      local TailShiftDown in
	 fun{TailShiftDown Partition Acc}
	    case Partition
	    of nil then Acc
	    [] H|T then
	       case H
	       of Note|Chord then
		  case Note
		  of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		     {TailShiftDown T Acc|{TailShiftDown Chord Acc|{TransposeExtendedNoteDown Note}}}
		  else
		     {TailShiftDown T Acc|{ChordToExtendedTransposedDown H}}
		  end
	       []note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		  {TailShiftDown T Acc|{TransposeExtendedNoteDown H}}
	       []duration(seconds:DurationBis PartitionBis) then
		  {TailShiftDown T Acc|{SetDuration DurationBis PartitionBis}}
	       []stretch(factor:FactorBis PartitionBis) then
		  {TailShiftDown T Acc|{SetStretch FactorBis PartitionBis}}
	       []drone(note:NoteOrChord amount:Amount) then
		  {TailShiftDown T Acc|{SetDrone NoteOrChord Amount}}
	       []transpose(semitones:Integer PartitionBis) then
		  {TailShiftDown T Acc|{SetTranspose Integer PartitionBis}}
	       else
		  {TailShiftDown T Acc|{NoteToExtendedTransposedDown H}}
	       end
	    end
	 end
	 {TailShiftDown Partition nil}
      end
   end
 
   fun {GetTime Partition}
      local TailGetTime in
	 fun{TailGetTime Partition Acc}
	    case Partition
	    of nil then Acc
	    [] H|T then
	       case H
	       of Note|Chord then %% Si H est une liste, c'est un Chord
		  case Note
		  of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		     {TailGetTime T Acc+(Duration)}
		  [] Atom then %% si le premier element est un atom et non un record, on peut conclure que c'est un chord, pas un exchord
		     {TailGetTime T Acc+1.0}
		  end
	       [] note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		  {TailGetTime T Acc+(Duration)}
	       else
		  {TailGetTime T Acc+1.0}
	       end
	    end
	 end
	 {TailGetTime Partition 0.0}
      end
   end
 
   fun{SetDuration Duration Partition}
      local TailSetDuration Factor in
	 Factor = Duration/{GetTime Partition} %Durée d'une note ou d'un accord
	 fun{TailSetDuration Duration Partition Acc}
	    case Partition
	    of nil then Acc %Renvoie la partition
	    []H|T then
	       case H
	       of Note|Chord then %Si c'est une liste, c'est un Chord ou un extended chord
		  case Note
		  of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then %Si c'est un extended chord
		     {TailSetDuration Duration T Acc|{TailSetDuration Duration Chord Acc|note(name:Name octave:Octave sharp:Boolean duration:Duration*Factor instrument:none)}}
		  else
		     {TailSetDuration Duration T Acc|{ChordToExtendedWithTime H Factor}} % RÉFLECHIR À COMMENT RENVOYER UN EXTENDED CHORD ET PAS DES EXTENDED NOTES
		  end
	       [] note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		  {TailSetDuration Duration T Acc|note(name:Name octave:Octave sharp:Boolean duration:Duration*Factor instrument:none)}
	       []duration(seconds:DurationBis PartitionBis) then
		  {TailSetDuration Duration T Acc|{SetDuration DurationBis PartitionBis}}
	       []stretch(factor:FactorBis PartitionBis) then
		  {TailSetDuration Duration T Acc|{SetStretch FactorBis PartitionBis}}
	       []drone(note:NoteOrChord amount:Amount) then
		  {TailSetDuration Duration T Acc|{SetDrone NoteOrChord Amount}}
	       []transpose(semitones:Integer PartitionBis) then
		  {TailSetDuration Duration T Acc|{SetTranspose Integer PartitionBis}}
	       else
		  {TailSetDuration Duration T Acc|{NoteToExtendedWithTime H Factor}}
	       end
	    end
	 end
	 {TailSetDuration Duration Partition nil}
      end
   end
 
   fun{SetStretch Factor Partition}
      local Duration NewDuration in
	 Duration = {GetTime Partition}*Factor
	 {SetDuration Duration Partition}
      end
   end
 
   fun{SetDrone NoteOrChord Amount}
      local TailSetDrone in
	 fun{TailSetDrone NoteOrChord Amount Acc}
	    if Amount == 0 then Acc
	    else
	       case NoteOrChord
	       of Note|Chord then
		  case Note
		  of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		     {TailSetDrone NoteOrChord Amount-1 Acc|NoteOrChord}
		  else
		     {TailSetDrone NoteOrChord Amount-1 Acc|{ChordToExtended NoteOrChord}}
		  end
	       []note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		  {TailSetDrone NoteOrChord Amount-1 Acc|NoteOrChord}
	       []duration(seconds:DurationBis PartitionBis) then
		  {TailSetDrone NoteOrChord Amount-1 Acc|{SetDuration DurationBis PartitionBis}}
	       []stretch(factor:FactorBis PartitionBis) then
		  {TailSetDrone NoteOrChord Amount-1 Acc|{SetStretch FactorBis PartitionBis}}
	       []drone(note:NoteOrChord amount:Amount) then
		  {TailSetDrone NoteOrChord Amount-1 Acc|{SetDrone NoteOrChord Amount}}
	       []transpose(semitones:Integer PartitionBis) then
		  {TailSetDrone NoteOrChord Amount-1 Acc|{SetTranspose Integer PartitionBis}}
	       else
		  {TailSetDrone NoteOrChord Amount-1 Acc|{NoteToExtended NoteOrChord}}
	       end
	    end
	 end
	 {TailSetDrone NoteOrChord Amount nil}
      end
   end
 
   fun{SetTranspose Integer Partition}
      if Integer > 0 then
	 {ShiftUp Partition}
      else
	 {ShiftDown Partition}
      end
   end
end

 
  
   
 
  
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
   fun {PartitionToTimedList Partition}
      local F Acc in
	 fun{F Partition Acc}
	    case Partition %Qu'est ce que la partition
	    of nil then Acc %Si la liste est vide on renvoie notre accumulateur qui est
	    [] H|T then %Dans le cas où c'est une liste d'extended sound
	       case H %On se demande quel est l'élémet de notre liste
	       of Note|Chord then %Si c'est une liste c'est que c'est un accord (pas d'autre truc qui est une liste)
		  case Note
		  of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		     {F T Acc|H}
		  else
		     {F T Acc|{ChordToExtended H}}
		  end
	       [] silence(duration:Duration) then
		  {F T Acc|H}
	       [] note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		  {F T Acc|H}
	       []duration(seconds:DurationBis PartitionBis) then
		  {F T Acc|{SetDuration DurationBis PartitionBis}}
	       []stretch(factor:FactorBis PartitionBis) then
		  {F T Acc|{SetStretch FactorBis PartitionBis}}
	       []drone(note:NoteOrChord amount:Amount) then
		  {F T Acc|{SetDrone NoteOrChord Amount}}
	       []transpose(semitones:Integer PartitionBis) then
		  {F T Acc|{SetTranspose Integer PartitionBis}}
	       else
		  {F T Acc|{NoteToExtended H}}
	       end
	    end
	 end
	 {F Partition Nil}
      end
   end
  
                                  
                                  
                                  
 
                                 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fun{GetHeigth Note}
      local A in
	 A= {NoteToExtended Note}
	 case A
	 of silence(duration:Duration) then 0
	 else
	    if A.name==c then
	       if A.sharp then
		  ((A.octave-4)*12)-8
	       else
		  ((A.octave-4)*12)-9
	       end
	    elseif A.name==d then
	       if A.sharp then
		  ((A.octave-4)*12)-6
	       else
		  ((A.octave-4)*12)-7
	       end
	    elseif A.name==e then
	       ((A.octave-4)*12)-5
	    elseif A.name==f then
	       if A.sharp then
		  ((A.octave-4)*12)-3
	       else
		  ((A.octave-4)*12)-4
	       end
	    elseif A.name==g then
	       if A.sharp then
		  ((A.octave-4)*12)-1
	       else
		  ((A.octave-4)*12)-2
	       end
	    elseif
	       A.name==a then
	       if A.sharp then
		  ((A.octave-4)*12)+1
	       else
		  ((A.octave-4)*12)
	       end
	    else
	       ((A.octave-4)*12)+2
	    end
	 end 
      end
   end
  
   fun{GetFrequency Note}
      local Factor in
	 Factor=({IntToFloat {GetHeigth Note}}/12.0)
	 {Pow 2.0 Factor}*440.0
      end
   end

    fun{Sum A B}%Renvoie une liste de sommes éléments par éléments si les listes sont de meme tailles 
      local Tail in
                fun{Tail A B Acc}
                    case A of nil then {Reverse Acc}
                    []HA|TA then
                       case B of HB|TB then
                                  {Tail TA TB HA+HB|Acc}
                       end
                    end
                end
                {Tail A B nil}
      end
   end
 
   fun{Fill Gaps List}           %% égalise deux listes en completant la plus courte par des 0.0 
      local Tail in
                fun{Tail Gaps List Acc}
                    if Gaps == 0 then {Append List {Reverse Acc}}
                    else {Tail Gaps-1 List 0.0|Acc}
                    end
                end
                {Tail Gaps List nil}
      end
   end
 
   fun{BigSum A B}                                  %%Somme des listes élément par élément et allonge la liste la plus courte 
      local Diff = {Length A} - {Length B} in
                if Diff == 0 then {Sum A B}
                elseif Diff > 0 then {Sum A {Fill Diff B}}
                else {Sum {Fill ~Diff A} B}
                end
      end
   end
   
   fun{NoteToSample Note}
      local TailNoteToSample in           
	 fun{TailNoteToSample ExNote Acc1 Acc2}
	    case ExNote
	    of silence(duration:Duration) then
	       if ({Length Acc1} < Duration*44100) then
		  {TailNoteToSample Note 0|Acc1 Acc2}
	       else
		  Acc1
	       end
	    []note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then 
	       if ({Length Acc1} <Duration*44100) then
		  {TailNoteToSample Note (0.5*{Sin 2.0*3.14159265359*{GetFrequency Note}*(Acc2/44100.0)})|Acc1 Acc2+(1.0/{IntToFloat Duration})} %% gère le cas ou la duration est un entier quelconque. 
	       else
		  Acc1
	       end
	    end
	 end
	 {TailNoteToSample Note nil 0.0}
      end
   end
   
   fun{ChordToSample Chord}        %% risque de passer au dessus/dessous des bornes ]~1.0;1.0[ mais on ne doit pas gerer le cas dans le code, juste que ca n'arrive pas dans les exemples 
      ChordExtended = {ChordToExtended Chord}
      case ChordExtended
      of H|T then
	 {BigSum {NoteToSample H} {ChordToSample T}}
      end
   end

   fun{Merge MusicsWithIntensities}   %% prends une liste de musique qui ont chacune une intensité associée renvoie la somme vectorielle pondérée par les intensités
      local TailMerge in
	 fun{TailMerge MusicsWithIntensities Acc}
	    case MusicsWithIntensities of H|T then
	    end
	 end
      end
   end
   
	       
   
   
   
   fun {Mix P2T Music}
      local TailMix in
	 fun{TailMix P2T Music FinalList}
	     case Music 
	    of nil then {Reverse Acc}
	    [] H|T then
	       case H
	       of samples(Samples) then
		  {TailMix T H|FinalList}
	       []partition(Partition) then
		  case {P2T Partition}
		  of H2|T2 then
		     case H2 of X|Y then
			{TailMix T2 {Append {ChordToSample H2} Acc}}
		     []note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none)
			{TailMix T2 {Append {NoteToSample H2} Acc}}
		     end
		  end
	       []wave(FileName) then  %% à verif 
		  {Project.load H.1}
	       []merge(MusicWithIntensities) then
	       []reverse(Music) then
	       []repeat(amount:Natural Music) then
	       []loop(seconds:Duration Music) then
	       []clip(low:Sample1 high:Sample2 Music) then
	       []echo(delay:Duration decay:Factor Music) then
	       []fade(start:Duration1 out:Duration2 Music) then
	       []cut(start:Duration1 finish:Duration2 Music) then
	       end
	    end
	 end
      end
   end

   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   Music = {Project.load 'joy.dj.oz'}
   Start
   
   % Uncomment next line to insert your tests.
   % \insert 'tests.oz'
   % !!! Remove this before submitting.
in
   Start = {Time}
   
   % Uncomment next line to run your tests.
   % {Test Mix PartitionToTimedList}
   
   % Add variables to this list to avoid "local variable used only once"
   % warnings.
   {ForAll [NoteToExtended Music] Wait}
   
   % Calls your code, prints the result and outputs the result to `out.wav`.
   % You don't need to modify this.
   {Browse {Project.run Mix PartitionToTimedList Music 'out.wav'}}
   
   % Shows the total time to run your code.
   {Browse {IntToFloat {Time}-Start} / 1000.0}
end
