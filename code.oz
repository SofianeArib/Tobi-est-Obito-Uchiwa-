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
      [] note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none)
      [] silence(duration:Duration) then silence(duration:Duration)
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
	    of nil then {Reverse Acc}
	    [] H|T then
	       {Tail T {NoteToExtended H}|Acc}
	    end
	 end
	 {Tail Chord nil}
      end
   end

   fun{NoteToExtendedWithTime Note Factor} %Note to extended note with duration:Factor for the note
      case Note
      of Name#Octave then
	 note(name:Name octave:Octave sharp:true duration:Factor instrument:none)
      []note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then note(name:Name octave:Octave sharp:Boolean duration:Duration*Factor instrument:none)
      []silence(duration:Duration) then silence(duration:Duration*Factor)
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
	    of nil then {Reverse Acc}
	    [] H|T then
	       {Tail T Factor {NoteToExtendedWithTime H Factor}|Acc}
	    end
	 end
	 {Tail Chord Factor nil}
      end
   end

   fun{NoteToExtendedTransposedUp Note}
      local E Z in
	 case Note
	 of Name#Octave then
	    if Name == g then note(name:a octave:Octave sharp:false duration:1.0 instrument:none)
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
	       [] b then note(name:c octave:5 sharp:false duration:1.0 instrument:none)
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
	       [] b then note(name:c octave:Z+1 sharp:false duration:1.0 instrument:none)
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
	    of nil then {Reverse Acc}
	    [] H|T then
	       {Tail T {NoteToExtendedTransposedUp H}|Acc}
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
	       of a then note(name:g octave:4 sharp:true duration:1.0 instrument:none)
	       [] b then note(name:a octave:4 sharp:true duration:1.0 instrument:none)
	       [] c then note(name:b octave:3 sharp:false duration:1.0 instrument:none)
	       [] d then note(name:c octave:4 sharp:true duration:1.0 instrument:none)
	       [] e then note(name:d octave:4 sharp:true duration:1.0 instrument:none)
	       [] f then note(name:e octave:4 sharp:false duration:1.0 instrument:none)
	       else note(name:f octave:4 sharp:true duration:1.0 instrument:none)
	       end
	    [] [N O] then
	       E = {StringToAtom [N]}
	       Z = {StringToInt [O]}
	       case E
	       of a then note(name:g octave:Z sharp:true duration:1.0 instrument:none)
	       [] b then note(name:a octave:Z sharp:true duration:1.0 instrument:none)
	       [] c then note(name:b octave:Z-1 sharp:false duration:1.0 instrument:none)
	       [] d then note(name:c octave:Z sharp:true duration:1.0 instrument:none)
	       [] e then note(name:d octave:Z sharp:true duration:1.0 instrument:none)
	       [] f then note(name:e octave:Z sharp:false duration:1.0 instrument:none)
	       else note(name:f octave:Z sharp:true duration:1.0 instrument:none)
	       end
	    end
	 []silence then silence(duration:1.0)
	 end
      end
   end

   fun{ChordToExtendedTransposedDown Chord}
      local Tail in
	 fun{Tail Chord Acc}
	    case Chord
	    of nil then {Reverse Acc}
	    [] H|T then
	       {Tail T {NoteToExtendedTransposedDown H}|Acc}
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
      []silence(duration:Duration) then silence(duration:Duration)
      else ExtendedNote
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
	    if Name == a then note(name:g octave:Octave sharp:true duration:Duration instrument:none)
	    elseif Name == b then note(name:a octave:Octave sharp:true duration:Duration instrument:none)
	    elseif Name == c then note(name:b octave:Octave-1 sharp:false duration:Duration instrument:none)
	    elseif Name == d then note(name:c octave:Octave sharp:true duration:Duration instrument:none)
	    elseif Name == e then note(name:d octave:Octave sharp:true duration:Duration instrument:none)
	    elseif Name == f then note(name:e octave:Octave sharp:false duration:Duration instrument:none)
	    else note(name:f octave:Octave sharp:true duration:Duration instrument:none)
	    end
	 end
      []silence(duration:Duration) then silence(duration:Duration)
      else ExtendedNote
      end
   end

   fun{ShiftUp Partition}
      local TailShiftUp in
	 fun{TailShiftUp Partition Acc}
	    case Partition
	    of nil then {Reverse Acc} 
	    [] H|T then
	       case H
	       of Note|Chord then
		  case Note
		  of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		     {TailShiftUp T {TailShiftUp Chord {TransposeExtendedNoteUp Note}}|Acc}
		  []silence(duration:Duration) then
		     {TailShiftUp T {TailShiftUp Chord {TransposeExtendedNoteUp Note}}|Acc}
		  else
		     {TailShiftUp T {ChordToExtendedTransposedUp H}|Acc}
		  end
	       []silence(duration:Duration) then
		  {TailShiftUp T {TransposeExtendedNoteUp H}|Acc}
	       []note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		  {TailShiftUp T {TransposeExtendedNoteUp H}|Acc}
	       []duration(seconds:DurationBis PartitionBis) then
		  {TailShiftUp T {Append {ShiftUp {Reverse {SetDuration DurationBis PartitionBis}}} Acc}}
	       []stretch(factor:FactorBis PartitionBis) then
		  {TailShiftUp T {Append {ShiftUp {Reverse {SetStretch FactorBis PartitionBis}}} Acc}}
	       []drone(note:NoteOrChord amount:Amount) then 
		  {TailShiftUp T {Append {ShiftUp {Reverse {SetDrone NoteOrChord Amount}}} Acc}}
	       []transpose(semitones:Integer PartitionBis) then
		  {TailShiftUp T {Append {ShiftUp {Reverse {SetTranspose Integer PartitionBis}}} Acc}}
	       else
		  {TailShiftUp T {NoteToExtendedTransposedUp H}|Acc}
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
	    of nil then {Reverse Acc}
	    [] H|T then
	       case H
	       of Note|Chord then
		  case Note
		  of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		     {TailShiftDown T {TailShiftDown Chord {TransposeExtendedNoteDown Note}|Acc}|Acc}
		  []silence(duration:Duration) then
		     {TailShiftDown T {TailShiftDown Chord {TransposeExtendedNoteDown Note}|Acc}|Acc}
		  else
		     {TailShiftDown T {ChordToExtendedTransposedDown H}|Acc}
		  end
	       [] silence(duration:Duration) then
		  {TailShiftDown T {TransposeExtendedNoteDown H}|Acc}
	       []note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		  {TailShiftDown T {TransposeExtendedNoteDown H}|Acc}
	       []duration(seconds:DurationBis PartitionBis) then
		  {TailShiftDown T {Append {ShiftDown {Reverse {SetDuration DurationBis PartitionBis}}} Acc}}
	       []stretch(factor:FactorBis PartitionBis) then
		  {TailShiftDown T {Append {ShiftDown {Reverse {SetStretch FactorBis PartitionBis}}} Acc}}
	       []drone(note:NoteOrChord amount:Amount) then 
		  {TailShiftDown T {Append {ShiftDown {Reverse {SetDrone NoteOrChord Amount}}} Acc}}
	       []transpose(semitones:Integer PartitionBis) then
		  {TailShiftDown T {Append {ShiftDown {Reverse {SetTranspose Integer PartitionBis}}} Acc}}
	       else
		  {TailShiftDown T {NoteToExtendedTransposedDown H}|Acc}
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
		     {TailGetTime T Acc+Duration}
		  []silence(duration:Duration) then
		     {TailGetTime T Acc+Duration}
		  else %% si le premier element est un atom et non un record, on peut conclure que c'est un chord, pas un exchord
		     {TailGetTime T Acc+1.0}
		  end
	       [] silence(duration:Duration) then
		  {TailGetTime T (Acc+Duration)}
	       [] note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		  {TailGetTime T (Acc+Duration)}
	       []duration(seconds:DurationBis PartitionBis) then
		  {TailGetTime T (Acc+DurationBis)}
	       []stretch(factor:FactorBis PartitionBis) then
		  {TailGetTime T (Acc+{GetTime PartitionBis}*{IntToFloat FactorBis})}
	       []drone(note:NoteOrChord amount:Amount) then 
		  {TailGetTime T Acc+{IntToFloat Amount}*{GetTime NoteOrChord}}
	       []transpose(semitones:Integer PartitionBis) then
		  {TailGetTime T (Acc+{GetTime PartitionBis})}
	       else
		  {TailGetTime T Acc+1.0}
	       end
	    else {TailGetTime Partition|nil 0.0}
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
	    of nil then {Reverse Acc} %Renvoie la partition
	    []H|T then
	       case H
	       of Note|Chord then %Si c'est une liste, c'est un Chord ou un extended chord
		  case Note
		  of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then %Si c'est un extended chord
		     {TailSetDuration Duration T {TailSetDuration Duration Chord note(name:Name octave:Octave sharp:Boolean duration:Duration*Factor instrument:none)|Acc}|Acc}
		  []silence(duration:Duration) then
		     {TailSetDuration Duration T {TailSetDuration Duration Chord silence(duration:Duration*Factor)|Acc}|Acc}
		  else
		     {TailSetDuration Duration T {ChordToExtendedWithTime H Factor}|Acc} % RÉFLECHIR À COMMENT RENVOYER UN EXTENDED CHORD ET PAS DES EXTENDED NOTES
		  end
	       []duration(seconds:DurationBis PartitionBis) then
		  {TailSetDuration Duration T {Append {Reverse {SetDuration Duration {SetDuration DurationBis PartitionBis}}} Acc}}
	       []stretch(factor:FactorBis PartitionBis) then
		  {TailSetDuration Duration T {Append {Reverse {SetStretch Factor {SetStretch FactorBis PartitionBis}}} Acc}}
	       []drone(note:NoteOrChord amount:Amount) then 
		  {TailSetDuration Duration T {Append {Reverse {SetStretch Factor {SetDrone NoteOrChord Amount}}} Acc}}
	       []transpose(semitones:Integer PartitionBis) then
		  {TailSetDuration Duration T {Append {Reverse {SetDuration Duration {SetTranspose Integer PartitionBis}}} Acc}}
	       else
		  {TailSetDuration Duration T {NoteToExtendedWithTime H Factor}|Acc}
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

   fun{Copy Element Integer}
      local Tail in
	 fun{Tail Element Integer Acc}
	    if Integer == 0 then {Reverse Acc}
	    else
	       {Tail Element Integer-1 Element|Acc}
	    end
	 end
	 {Tail Element Integer nil}
      end
   end
	    
   
   fun{SetDrone NoteOrChord Amount}
      case NoteOrChord
      of Note|Chord then
	 case Note
	 of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
	    {Copy NoteOrChord Amount}
	 []silence(duration:Duration) then
	    {Copy NoteOrChord Amount}
	 else
	    {Copy {ChordToExtended NoteOrChord} Amount}
	 end
      []silence(duration:Duration) then
	 {Copy NoteOrChord Amount}
      []note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
	 {Copy NoteOrChord Amount}
      []duration(seconds:DurationBis PartitionBis) then
	 {Flatten {Copy {SetDuration DurationBis PartitionBis} Amount}}
      []stretch(factor:FactorBis PartitionBis) then
	 {Flatten {Copy {SetStretch FactorBis PartitionBis} Amount}}
      []drone(note:NoteOrChord amount:AmountBis) then 
	 {Flatten {Copy {SetDrone NoteOrChord AmountBis} Amount}}
      []transpose(semitones:Integer PartitionBis) then
	 {Flatten {Copy {SetTranspose Integer PartitionBis} Amount}}
      else
	 {Copy {NoteToExtended NoteOrChord} Amount}
      end
   end

   fun{SetTranspose Integer Partition}
      if Integer == 0 then Partition
      elseif Integer >= 1 then {SetTranspose Integer-1 {ShiftUp Partition}}
      else {SetTranspose Integer+1 {ShiftDown Partition}}
      end
   end
   
   

   
   

   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   fun {PartitionToTimedList Partition}
      local F Acc in
	 fun{F Partition Acc}
	    case Partition %Qu'est ce que la partition
	    of nil then {Reverse Acc} %Si la liste est vide on renvoie notre accumulateur qui est 
	    [] H|T then %Dans le cas où c'est une liste d'extended sound
	       case H %On se demande quel est l'élémet de notre liste
	       of Note|Chord then %Si c'est une liste c'est que c'est un accord (pas d'autre truc qui est une liste)
		  case Note
		  of note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		     {F T H|Acc}
		  []silence(duration:Duration) then
		     {F T H|Acc}
		  else 
		     {F T {ChordToExtended H}|Acc}
		  end
	       [] silence(duration:Duration) then
		  {F T H|Acc}
	       [] note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none) then
		  {F T H|Acc}
	       []duration(seconds:DurationBis PartitionBis) then
		  {F T {Append {Reverse {SetDuration DurationBis PartitionBis}} Acc}}
	       []stretch(factor:FactorBis PartitionBis) then
		  {F T {Append {Reverse {SetStretch FactorBis PartitionBis}} Acc}}
	       []drone(note:NoteOrChord amount:Amount) then 
		  {F T {Append {Reverse {SetDrone NoteOrChord Amount}} Acc}}
	       []transpose(semitones:Integer PartitionBis) then
		  {F T {Append {Reverse {SetTranspose Integer PartitionBis}} Acc}}
	       else
		  {F T {NoteToExtended H}|Acc}
	       end
	    end
	 end
	 {F Partition nil}
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

    fun{Sum A B}%Renvoie une liste de sommes éléments par éléments
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
 
   fun{Fill Gaps List}
      local Tail in
                fun{Tail Gaps List Acc}
                    if Gaps == 0 then {Append List {Reverse Acc}}
                    else {Tail Gaps-1 List 0|Acc}
                    end
                end
                {Tail Gaps List nil}
      end
   end
 
   fun{BigSum A B}
      local Diff = {Length A} - {Length B} in
                if Diff == 0 then {Sum A B}
                elseif Diff > 0 then {Sum A {Fill Diff B}}
                else {Sum {Fill ~Diff A} B}
                end
      end
   end
   
   fun{NoteToSample Note}
      local TailNoteToSample in
	 fun{TailNoteToSample Note Acc1 Acc2}
	    case Note
	    of [115 105 108 101 110 99 101] then
	       if ({Length Acc1} < 44100) then
		  {TailNoteToSample Note 0|Acc1 Acc2}
	       else
		  Acc1
	       end
	    else
	       if ({Length Acc1} <44100) then
		  {TailNoteToSample Note (0.5*{Sin 2.0*3.14159265359*{GetFrequency Note}*(Acc2/44100.0)})|Acc1 Acc2+1.0}
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
	 {Sum {NoteToSample H} {ChordToSample T}}
      end
   end
   
  
   fun {ToSample Music}
      local TailToSample in
	 fun{TailToSample Music Acc}
	    case Music 
	    of nil then Acc
	    [] H|T then
	       case H
	       of samples(Samples) then
		  {TailToSample T H|Acc}
	       []partition(Partition) then
		  case {PartitionToTimedList Partition} %% A COMPLETER
		  of H2|T2 then
		     case H2 of X|Y then
			{TailToSample T2 {ChordToSample H2}|Acc}
		     []note(name:Name octave:Octave sharp:Boolean duration:Duration instrument:none)
			{TailToSample T2 {NoteToSample H2}|Acc}
		     end
		  else Acc	
	       []wave(FileName) then
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
   
   
   
   
   
   fun {Mix P2T Music}
      local TailMix in
	 fun{TailMix P2T Music}
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
