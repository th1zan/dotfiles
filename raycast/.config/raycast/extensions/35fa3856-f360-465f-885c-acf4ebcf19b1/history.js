"use strict";var yt=Object.create;var E=Object.defineProperty;var ft=Object.getOwnPropertyDescriptor;var At=Object.getOwnPropertyNames;var gt=Object.getPrototypeOf,wt=Object.prototype.hasOwnProperty;var g=(o,t)=>()=>(t||o((t={exports:{}}).exports,t),t.exports),Ct=(o,t)=>{for(var i in t)E(o,i,{get:t[i],enumerable:!0})},_=(o,t,i,r)=>{if(t&&typeof t=="object"||typeof t=="function")for(let e of At(t))!wt.call(o,e)&&e!==i&&E(o,e,{get:()=>t[e],enumerable:!(r=ft(t,e))||r.enumerable});return o};var vt=(o,t,i)=>(i=o!=null?yt(gt(o)):{},_(t||!o||!o.__esModule?E(i,"default",{value:o,enumerable:!0}):i,o)),xt=o=>_(E({},"__esModule",{value:!0}),o);var J=g((Vt,F)=>{"use strict";F.exports=function(t){var i=0,r;function e(){return i||(i=1,r=t.apply(this,arguments),t=null),r}return e.displayName=t.displayName||t.name||e.displayName||e.name,e}});var I=g((bt,K)=>{var P=require("child_process"),$=J(),L=class{constructor(){this.child=null,this.baseSpeed=0}speak(t,i,r,e){if(typeof e!="function"&&(e=()=>{}),e=$(e),!t)return setImmediate(()=>{e(new TypeError("say.speak(): must provide text parameter"))});let{command:s,args:d,pipedData:a,options:c}=this.buildSpeakCommand({text:t,voice:i,speed:r});this.child=P.spawn(s,d,c),this.child.stdin.setEncoding("ascii"),this.child.stderr.setEncoding("ascii"),a&&this.child.stdin.end(a),this.child.stderr.once("data",n=>{e(new Error(n))}),this.child.addListener("exit",(n,l)=>{if(n===null||l!==null)return e(new Error(`say.speak(): could not talk, had an error [code: ${n}] [signal: ${l}]`));this.child=null,e(null)})}export(t,i,r,e,s){if(typeof s!="function"&&(s=()=>{}),s=$(s),!t)return setImmediate(()=>{s(new TypeError("say.export(): must provide text parameter"))});if(!e)return setImmediate(()=>{s(new TypeError("say.export(): must provide filename parameter"))});try{var{command:d,args:a,pipedData:c,options:n}=this.buildExportCommand({text:t,voice:i,speed:r,filename:e})}catch(l){return setImmediate(()=>{s(l)})}this.child=P.spawn(d,a,n),this.child.stdin.setEncoding("ascii"),this.child.stderr.setEncoding("ascii"),c&&this.child.stdin.end(c),this.child.stderr.once("data",l=>{s(new Error(l))}),this.child.addListener("exit",(l,x)=>{if(l===null||x!==null)return s(new Error(`say.export(): could not talk, had an error [code: ${l}] [signal: ${x}]`));this.child=null,s(null)})}stop(t){if(typeof t!="function"&&(t=()=>{}),t=$(t),!this.child)return setImmediate(()=>{t(new Error("say.stop(): no speech to kill"))});this.runStopCommand(),this.child=null,t(null)}convertSpeed(t){return Math.ceil(this.baseSpeed*t)}getInstalledVoices(t){typeof t!="function"&&(t=()=>{}),t=$(t);let{command:i,args:r}=this.getVoices();var e=[];this.child=P.spawn(i,r),this.child.stdin.setEncoding("ascii"),this.child.stderr.setEncoding("ascii"),this.child.stderr.once("data",s=>{t(new Error(s))}),this.child.stdout.on("data",function(s){e+=s}),this.child.addListener("exit",(s,d)=>{if(s===null||d!==null)return t(new Error(`say.getInstalledVoices(): could not get installed voices, had an error [code: ${s}] [signal: ${d}]`));e.length>0&&(e=e.split(`\r
`),e=e[e.length-1]===""?e.slice(0,e.length-1):e),this.child=null,t(null,e)}),this.child.stdin.end()}};K.exports=L});var U=g((Bt,z)=>{var Et=I(),$t=100,It="festival",N=class extends Et{constructor(){super(),this.baseSpeed=$t}buildSpeakCommand({text:t,voice:i,speed:r}){let e=[],s="",d={};return e.push("--pipe"),r&&(s+=`(Parameter.set 'Audio_Command "aplay -q -c 1 -t raw -f s16 -r $(($SR*${this.convertSpeed(r)}/100)) $FILE") `),i&&(s+=`(${i}) `),s+=`(SayText "${t}")`,{command:It,args:e,pipedData:s,options:d}}buildExportCommand({text:t,voice:i,speed:r,filename:e}){throw new Error(`say.export(): does not support platform ${this.platform}`)}runStopCommand(){process.kill(this.child.pid+2)}getVoices(){throw new Error(`say.export(): does not support platform ${this.platform}`)}};z.exports=N});var X=g((Rt,G)=>{var Tt=I(),Dt=175,W="say",M=class extends Tt{constructor(){super(),this.baseSpeed=Dt}buildSpeakCommand({text:t,voice:i,speed:r}){let e=[],s="",d={};return i?e.push("-v",i,t):e.push(t),r&&e.push("-r",this.convertSpeed(r)),{command:W,args:e,pipedData:s,options:d}}buildExportCommand({text:t,voice:i,speed:r,filename:e}){let s=[],d="",a={};return i?s.push("-v",i,t):s.push(t),r&&s.push("-r",this.convertSpeed(r)),e&&s.push("-o",e,"--data-format=LEF32@32000"),{command:W,args:s,pipedData:d,options:a}}runStopCommand(){this.child.stdin.pause(),this.child.kill()}getVoices(){throw new Error(`say.export(): does not support platform ${this.platform}`)}};G.exports=M});var Y=g((_t,Q)=>{var Pt=require("child_process"),Lt=I(),Nt=0,k="powershell",q=class extends Lt{constructor(){super(),this.baseSpeed=Nt}buildSpeakCommand({text:t,voice:i,speed:r}){let e=[],s="",d={},a="Add-Type -AssemblyName System.speech;$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer;";if(i&&(a+=`$speak.SelectVoice('${i}');`),r){let c=this.convertSpeed(r||1);a+=`$speak.Rate = ${c};`}return a+="$speak.Speak([Console]::In.ReadToEnd())",s+=t,e.push(a),d.shell=!0,{command:k,args:e,pipedData:s,options:d}}buildExportCommand({text:t,voice:i,speed:r,filename:e}){let s=[],d="",a={},c="Add-Type -AssemblyName System.speech;$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer;";if(i&&(c+=`$speak.SelectVoice('${i}');`),r){let n=this.convertSpeed(r||1);c+=`$speak.Rate = ${n};`}if(e)c+=`$speak.SetOutputToWaveFile('${e}');`;else throw new Error("Filename must be provided in export();");return c+="$speak.Speak([Console]::In.ReadToEnd());$speak.Dispose()",d+=t,s.push(c),a.shell=!0,{command:k,args:s,pipedData:d,options:a}}runStopCommand(){this.child.stdin.pause(),Pt.exec(`taskkill /pid ${this.child.pid} /T /F`)}convertSpeed(t){return Math.max(-10,Math.min(Math.round(9.0686*Math.log(t)-.1806),10))}getVoices(){let t=[];return t.push("Add-Type -AssemblyName System.speech;$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer;$speak.GetInstalledVoices() | % {$_.VoiceInfo.Name}"),{command:k,args:t}}};Q.exports=q});var et=g((Ft,D)=>{var Mt=U(),kt=X(),qt=Y(),j="darwin",Z="linux",tt="win32",T=class{constructor(t){if(t||(t=process.platform),t===j)return new kt;if(t===Z)return new Mt;if(t===tt)return new qt;throw new Error(`new Say(): unsupported platorm! ${t}`)}};D.exports=new T;D.exports.Say=T;D.exports.platforms={WIN32:tt,MACOS:j,LINUX:Z}});var Ht={};Ct(Ht,{default:()=>ut});module.exports=xt(Ht);var f=require("@raycast/api"),R=require("react");var p=require("@raycast/api"),H=vt(et()),w=require("react/jsx-runtime");var O=o=>(0,w.jsx)(p.Action.CopyToClipboard,{icon:p.Icon.CopyClipboard,...o}),ot=({content:o})=>(0,w.jsx)(p.Action,{icon:p.Icon.SpeechBubble,title:"Speak",onAction:()=>{H.default.stop(),H.default.speak(o)},shortcut:{modifiers:["cmd","shift"],key:"p"}}),V=({onAction:o,title:t,modifiers:i})=>(0,w.jsx)(p.Action,{icon:p.Icon.Star,title:t,onAction:o,shortcut:{modifiers:i,key:"s"}}),it=({text:o,name:t})=>(0,w.jsx)(p.Action.CreateSnippet,{icon:p.Icon.Snippets,title:"Save as a Snippet",snippet:{text:o,name:t},shortcut:{modifiers:["cmd"],key:"n"}}),b=({icon:o=p.Icon.Trash,title:t,dialog:i,onAction:r,shortcut:e={modifiers:["ctrl"],key:"x"}})=>(0,w.jsx)(p.Action,{style:p.Action.Style.Destructive,icon:o,title:t,onAction:async()=>{await(0,p.confirmAlert)({title:i.title??t,message:i.message??"This action cannot be undone",icon:o,primaryAction:{title:i.primaryButton??t,style:p.Alert.ActionStyle.Destructive,onAction:r}})},shortcut:e});var st=require("@raycast/api");var v=require("react/jsx-runtime"),nt=({question:o,answer:t})=>(0,v.jsxs)(st.ActionPanel.Section,{title:"Copy",children:[(0,v.jsx)(O,{title:"Copy Answer",content:t}),(0,v.jsx)(O,{title:"Copy Question",content:o})]});var A=require("@raycast/api"),B=require("react/jsx-runtime"),rt=()=>(0,B.jsx)(A.ActionPanel.Section,{title:"Preferences",children:(0,B.jsx)(A.Action,{icon:A.Icon.Gear,title:"Open Extension Preferences",onAction:A.openExtensionPreferences})});var at=require("@raycast/api");var C=require("react/jsx-runtime"),ct=({onSaveConversationAction:o,onSaveAnswerAction:t,snippet:i})=>(0,C.jsxs)(at.ActionPanel.Section,{title:"Save",children:[o&&(0,C.jsx)(V,{title:"Save Conversation",onAction:o,modifiers:["cmd"]}),(0,C.jsx)(V,{title:"Save Answer",onAction:t,modifiers:o?["cmd","shift"]:["cmd"]}),i&&(0,C.jsx)(it,{text:i.text,name:i.name})]});var y=require("@raycast/api"),u=require("react");function dt(){let[o,t]=(0,u.useState)([]),[i,r]=(0,u.useState)(!0);(0,u.useEffect)(()=>{(async()=>{let a=await y.LocalStorage.getItem("history");a&&t(c=>[...c,...JSON.parse(a)]),r(!1)})()},[]),(0,u.useEffect)(()=>{y.LocalStorage.setItem("history",JSON.stringify(o))},[o]);let e=(0,u.useCallback)(async a=>{t([...o,a])},[t,o]),s=(0,u.useCallback)(async a=>{let c=await(0,y.showToast)({title:"Removing answer...",style:y.Toast.Style.Animated}),n=o.filter(l=>l.id!==a.id);t(n),c.title="Answer removed!",c.style=y.Toast.Style.Success},[t,o]),d=(0,u.useCallback)(async()=>{let a=await(0,y.showToast)({title:"Clearing history...",style:y.Toast.Style.Animated});t([]),a.title="History cleared!",a.style=y.Toast.Style.Success},[t]);return(0,u.useMemo)(()=>({data:o,isLoading:i,add:e,remove:s,clear:d}),[o,i,e,s,d])}var h=require("@raycast/api"),S=require("react");function lt(){let[o,t]=(0,S.useState)([]),[i,r]=(0,S.useState)(!0);(0,S.useEffect)(()=>{(async()=>{let a=await h.LocalStorage.getItem("savedChats");a&&t(c=>[...c,...JSON.parse(a)]),r(!1)})()},[]),(0,S.useEffect)(()=>{h.LocalStorage.setItem("savedChats",JSON.stringify(o))},[o]);let e=(0,S.useCallback)(async a=>{let c=await(0,h.showToast)({title:"Saving your answer...",style:h.Toast.Style.Animated}),n={...a,saved_at:new Date().toISOString()};t([...o,n]),c.title="Answer saved!",c.style=h.Toast.Style.Success},[t,o]),s=(0,S.useCallback)(async a=>{let c=await(0,h.showToast)({title:"Unsaving your answer...",style:h.Toast.Style.Animated}),n=o.filter(l=>l.id!==a.id);t(n),c.title="Answer unsaved!",c.style=h.Toast.Style.Success},[t,o]),d=(0,S.useCallback)(async()=>{let a=await(0,h.showToast)({title:"Clearing your saved answers...",style:h.Toast.Style.Animated});t([]),a.title="Saved answers cleared!",a.style=h.Toast.Style.Success},[t]);return(0,S.useMemo)(()=>({data:o,isLoading:i,add:e,remove:s,clear:d}),[o,i,e,s,d])}var pt=require("@raycast/api"),ht=require("react/jsx-runtime"),mt=o=>{let{chat:t,streamData:i}=o,r=i&&i.id===t.id,e=Math.floor(430/Math.min(Math.max(t.files?.length??0,1),2)),s=t.files?.map(a=>`![](file://${a}?raycast-width=${e})`).join(`
`)||"",d=`${r?i?.answer:t.answer}
\`\`\`
${t.question.trimEnd()}
\`\`\`
${s}

`;return(0,ht.jsx)(pt.List.Item.Detail,{markdown:d})};var m=require("react/jsx-runtime");function ut(){let o=lt(),t=dt(),[i,r]=(0,R.useState)(""),[e,s]=(0,R.useState)(null),d=n=>(0,m.jsxs)(f.ActionPanel,{children:[(0,m.jsx)(nt,{answer:n.answer,question:n.question}),(0,m.jsx)(ct,{onSaveAnswerAction:()=>o.add(n)}),(0,m.jsx)(f.ActionPanel.Section,{title:"Output",children:(0,m.jsx)(ot,{content:n.answer})}),(0,m.jsxs)(f.ActionPanel.Section,{title:"Delete",children:[(0,m.jsx)(b,{title:"Remove",dialog:{title:"Are you sure you want to remove this answer from your history?"},onAction:()=>t.remove(n)}),(0,m.jsx)(b,{title:"Clear History",dialog:{title:"Are you sure you want to clear your history?"},onAction:()=>t.clear(),shortcut:{modifiers:["cmd","shift"],key:"delete"}})]}),(0,m.jsx)(rt,{})]}),c=t.data.sort((n,l)=>new Date(l.created_at??0).getTime()-new Date(n.created_at??0).getTime()).filter((n,l,x)=>l===x.findIndex(St=>St.id===n.id)).filter(n=>i===""?!0:n.question.toLowerCase().includes(i.toLowerCase())||n.answer.toLowerCase().includes(i.toLowerCase()));return(0,m.jsx)(f.List,{isShowingDetail:c.length!==0,isLoading:t.isLoading,filtering:!1,throttle:!1,selectedItemId:e||void 0,onSelectionChange:n=>{n!==e&&s(n)},searchBarPlaceholder:"Search answer/question...",searchText:i,onSearchTextChange:r,children:t.data.length===0?(0,m.jsx)(f.List.EmptyView,{title:"No history",description:"Your recent questions will be showed up here",icon:f.Icon.Stars}):(0,m.jsx)(f.List.Section,{title:"Recent",subtitle:c.length.toLocaleString(),children:c.map(n=>(0,m.jsx)(f.List.Item,{id:n.id,title:n.question,accessories:[{text:new Date(n.created_at??0).toLocaleDateString()}],detail:(0,m.jsx)(mt,{chat:n}),actions:n&&e===n.id?d(n):void 0},n.id))})})}