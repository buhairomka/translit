CREATE OR REPLACE FUNCTION get(input text) RETURNS text AS $$
	DECLARE rule jsonb:='{
    "А": "A", "а": "а",
    "Б": "B", "б": "b",
    "В": "V", "в": "v",
    "Г": "H", "г": "h",
    "Ґ": "G", "ґ": "g",
    "Д": "D", "д": "d",
    "Е": "E", "е": "е",
    "Є": "Ie", "є": "ie",
    "Ж": "Zh", "ж": "zh",
    "З": "Z", "з": "z",
    "И": "Y", "и": "y",
    "І": "I", "і": "i",
    "Ї": "I", "ї": "i",
    "Й": "Y", "й": "i",
    "К": "K", "к": "k",
    "Л": "L", "л": "l",
    "М": "M", "м": "m",
    "Н": "N", "н": "n",
    "О": "O", "о": "o",
    "П": "P", "п": "p",
    "Р": "R", "р": "r",
    "С": "S", "с": "s",
    "Т": "T", "т": "t",
    "У": "U", "у": "u",
    "Ф": "F", "ф": "f",
    "Х": "Kh", "х": "kh",
    "Ц": "Ts", "ц": "ts",
    "Ч": "Ch", "ч": "ch",
    "Ш": "Sh", "ш": "sh",
    "Щ": "Shch", "щ": "shch",
    "Ю": "Iu", "ю": "iu",
    "Я": "Ia", "я": "ia",
    "Зг": "Zgh", "зг": "zgh",
 "`": "",
    "’": "", "''": "",
    "ь": "", "Ь": ""
}';

	declare firstrule jsonb:='{
    "Є": "Ye", "є": "ye",
    "Ї": "Yi", "ї": "yi",
    "Ю": "Y", "ю": "y",
    "Я": "Ya", "я": "ya"
}';
declare res text='';
declare counter int=1;
BEGIN

	while counter <= CHAR_LENGTH($1)
		LOOP
			if (rule->substring($1,counter-1,1) is null)
				and (firstrule->>substring($1,counter,1) is not null)
			then res:= concat(res,firstrule->>substring($1,counter,1));
				counter:=counter+1;
				
			elsif rule->substring($1,counter,1) is not null
			then 
				if (substring($1,counter,1) = 'з' or substring($1,counter,1) = 'З') 
					and (substring($1,counter+1,1) = 'г' or substring($1,counter+1,1) = 'Г')
				then res:= concat(res,rule->>substring($1,counter,1));
					 counter:=counter+1;
					 res:= concat(res,'gh');
					 counter:=counter+1;
					 continue;
				else
					res:= concat(res,(rule->>substring($1,counter,1)));
					counter:=counter+1;
				end if;
			else res:= concat(res,substring($1,counter,1));
				counter:=counter+1;
			end if;

			
		END LOOP;   
	return res;
END;
$$ LANGUAGE plpgsql;

select * from get('Яблуко, їжак. Ялта, парус. Янукович, "каюта", розв''`’язувати задачі з розгону тіла.!?*%;');

