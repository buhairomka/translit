const rule = {
    'А': 'A', 'а': "а",
    'Б': 'B', 'б': "b",
    'В': 'V', 'в': "v",
    'Г': 'H', 'г': "h",
    'Ґ': 'G', 'ґ': "g",
    'Д': 'D', 'д': "d",
    'Е': 'E', 'е': "е",
    'Є': "Ie", 'є': "ie",
    'Ж': 'Zh', 'ж': "zh",
    'З': "Z", 'з': "z",
    'И': "Y", 'и': "y",
    'І': "I", 'і': "i",
    'Ї': "I", 'ї': "i",
    'Й': "Y", 'й': "i",
    'К': "K", 'к': "k",
    'Л': "L", 'л': "l",
    'М': "M", 'м': "m",
    'Н': "N", 'н': "n",
    'О': "O", 'о': "o",
    'П': "P", 'п': "p",
    'Р': "R", 'р': "r",
    'С': "S", 'с': "s",
    'Т': "T", 'т': "t",
    'У': "U", 'у': "u",
    'Ф': "F", 'ф': "f",
    'Х': "Kh", 'х': "kh",
    'Ц': "Ts", 'ц': "ts",
    'Ч': "Ch", 'ч': "ch",
    'Ш': "Sh", 'ш': "sh",
    'Щ': "Shch", 'щ': "shch",
    'Ю': 'Iu', 'ю': "iu",
    'Я': 'Ia', 'я': "ia",
    'Зг': 'Zgh', 'зг': 'zgh',
    "\"": "", "`": "",
    "’": "", "'": "",
    "ь": "", "Ь": ""
}

const firstRule = {
    'Є': "Ye", 'є': "ye",
    'Ї': "Yi", 'ї': "yi",
    'Ю': "Y", 'ю': 'y',
    'Я': "Ya", 'я': 'ya',

}


function translit(text) {
    return text.split(" ").map((word) => {
        // перевірка на зг
        if (word.match('зг|Зг|ЗГ')){
            word = word.replace('зг','zgh').replace('Зг','Zgh').replace('ЗГ',"ZGH")
        }
        // перевірка на наявність я ю є ї на початку слова
        if (["Я", "Ю", "Є", "Ї", 'я', 'ю', 'є', 'ї'].includes(word[0])) {
            let head = firstRule[(word[0])]
            let tail = word.slice(1).split('').map((char) => {
                if (Object.keys(rule).includes(char)) {
                    return rule[char]
                } else {
                    return char
                }
            }).join('')
            return head + tail
        } else {
            return word.split('').map(
                (char) => {
                    if (Object.keys(rule).includes(char)) {
                        return rule[char]
                    } else {
                        return char
                    }
                }
            ).join('')
        }
    }).join(" ")
}

text =  "Яблуко, їжак. Ялта, парус. Янукович, каюта, розв'`\"’язувати задачі з розгону тіла.!?*%;"
console.log(translit(text))