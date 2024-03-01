var body = document.getElementById('body');
var FirstBack = document.getElementById('FirstBack');
var GangName = document.getElementById('GangName');
var GangTut = document.getElementById('GangTut');
var UserGangRank = document.getElementById('UserGangRank');
var OpenSound = document.getElementById("OpenSound");
var ClickSound = document.getElementById("ClickSound");
let isMouseDown = false;
let lastMouseX = 0;
let lastMouseY = 0;
const allBackGround = document.getElementById('allBackGround');

window.addEventListener('message', function(event) {
    if (event.data.CheckUi === "OpenUi") {
    OpenSound.currentTime = 0
    OpenSound.play();
    OpenSound.volume = 0.282;
    allBackGround.style.animation = "V7ZoomIn 0.2s"
    allBackGround.style.scale = "1"
      body.style.display = "block"
    } else if (event.data.CheckUi === 'CloseUi') {
      body.style.display = "none"
    } else if (event.data.CheckUi === 'Refresh') {
        Gang = event.data.Ganginfo;
        ResetGangs()
    };
});

function ResetGangs() {
    $("#IdForSendData").empty();
    Gang.forEach(function(item) {
        $("#FirstBack").css('background-color', item.backgroundColor)
        $("#GangName").html(item.GangName);
        $("#GangTut").html(item.GangTut)
        $("#IdForSendData").append(`
            <div class="Data" id="Data">
                <span class="UserIcon" id="UserIcon">${item.UserIcon}</span>
                <span class="UserName" id="UserName">${item.UserName}</span>
                <span class="UserGangRank" id="UserGangRank">${item.UserGangRank}</span>
                <span class="Radio" id="Radio">${item.Radio}</span>
            </div>
        `);
    });
}

FirstBack.addEventListener('mousedown', function (event) {
    if (event.button === 0) {
        ClickSound.currentTime = 0
        ClickSound.play();
        ClickSound.volume = 0.282;
        FirstBack.style.cursor = "grabbing"
        isMouseDown = true;
        lastMouseX = event.clientX;
        lastMouseY = event.clientY;
    }
});

document.addEventListener('mousemove', function (event) {
    if (isMouseDown) {
        const dx = event.clientX - lastMouseX;
        const dy = event.clientY - lastMouseY;
        const rect = allBackGround.getBoundingClientRect();
        allBackGround.style.left = rect.left + dx + 'px';
        allBackGround.style.top = rect.top + dy + 'px';
        lastMouseX = event.clientX;
        lastMouseY = event.clientY;
    }
});

document.addEventListener('mouseup', function () {
    FirstBack.style.cursor = "grab"
    isMouseDown = false;
});

$(document).keyup(function(e){
    if (e.keyCode == 27){
        $.post(`https://${GetParentResourceName()}/closeMenu`);
    }
  })
