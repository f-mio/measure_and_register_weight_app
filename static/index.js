async function getWeight() {
    const getWeightEndpoint = `${apiBaseUrl}/weight`,
        requestHeaders = new Headers();

    const weightApiRes = await fetch(getWeightEndpoint, {
        method: 'GET',
        headers: requestHeaders
    });

    weightRes = await weightApiRes.json();

    if (weightRes > 0) {
        weightValueArea = document.querySelector('.weight-display');
        weightValueArea.innerText = weightRes;
    };
}


// async function addTemporaryTable() {
function submitTmpTableBtnClick(){
    /*
    description
      一時保存テーブルへ追加するためのボタンをクリックした際のイベント。
    input
      None
    output
      None
    Exception
      - (TODO) XXXX
    */

    const colClassNameList = ["remove-btn-area","record-team-id", "record-team-name", "record-waste-id", "record-waste-name", "record-waste-weight"];

    const theadElement = document.querySelector('thead'),
        checkThElement = theadElement.querySelector('th');

    const tbodyElement = document.querySelector('tbody');

    // team情報の取り出し
    const selectTeamForm = document.getElementById("select_team_form"),
        teamId = selectTeamForm.value;
    let teamName;

    teamOptions = selectTeamForm.querySelectorAll('option')
    teamOptions.forEach( option => {
        if (option.value == teamId) {
            teamName = option.innerText
        }
    })

    // waste情報の取り出し
    const selectWasteForm = document.getElementById('select_waste_form'),
        wasteId = selectWasteForm.value;
    let wasteName;

    wasteOptions = selectWasteForm.querySelectorAll('option');
    wasteOptions.forEach( option => {
        if (option.value == wasteId) {
            wasteName = option.innerText;
        };
    })

    // weightの取り出し
    const weightValue = document.getElementById("weight_value").innerText;

    const newRecord = [null, teamId, teamName, wasteId, wasteName, weightValue]

    if (teamId!="0" && wasteId !="0") {
        // header作成が必要か確認。　必要な場合作成する。
        if (checkThElement == null) {
            const headerRecord = ["削除","班id", "班名", "ゴミid", "ゴミ名", "廃棄量"];
            addRecordToTmpTable(theadElement, "th", colClassNameList, headerRecord);
        };
        addRecordToTmpTable(tbodyElement, "td", colClassNameList, newRecord);
    };
}


function addRecordToTmpTable(destinationElement, colType, colClassNameList, record) {
    /*
    description
      DB登録用テーブルにデータを記載する。
    input
      - destinationElement : object
      　　　要素の追加先 (thead or tbody)
      - colType : string
      　　　追加要素の種類 (th or td)  
      - colClassNameList : list
      　　　追加要素のClass名
      - record : list
      　　　テーブルに追加する値を含んだリストthrow new Error(`入力したASIN[${asin}]は不適切なASINです。10桁で入力してください。`);
        - waste_name
        - team_name
        - waste_weight
        - waste_id
        - team_id
    output
      None
    Exception
      - recordとcolClassNameListの長さが一致しない場合。
    */

    if (colClassNameList.length != record.length) {
        throw new Error(`recordの値が不正です。`);
    }

    const trElement = document.createElement("tr");
    let i = 0;
    record.forEach( colValue => {
        const colElement = document.createElement(`${colType}`);
        colElement.setAttribute('class', `${colClassNameList[i]}`);
        colElement.innerText = colValue;

        // 先頭に削除用ボタンを挿入
        if (i==0 && (colType == "td")) {
            const removeBtnImg = document.createElement("img");
            removeBtnImg.setAttribute('class', 'remove-btn-img');
            removeBtnImg.setAttribute('src', removeBtnUrl)
            removeBtnImg.setAttribute('alt', '削除ボタン')
            colElement.appendChild(removeBtnImg);
        };

        trElement.appendChild(colElement);
        i = i + 1
    });
    destinationElement.appendChild(trElement);
};


// TODO
function submitDbBtnClick() {
    /*
    description
      ゴミ情報の一時格納テーブルの内容をDBに登録する。
    input
      None
    output
      None
    */

    clearAllRecord()
}


function clearAllRecord() {
    /*
    description
      ゴミ情報の一時格納テーブルを削除する。
    input
      None
    output
      None
    */

    const trElements = document.querySelectorAll('tr');
    trElements.forEach( trElement => {
        trElement.remove();
    } )
}