<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript">
	$(function() {
		loadOptionBox({
		    url:"/background/dicType/findDicType.html",
		    boxId:"dicTypeId",
		    optionValue:"id",
		    optionName:"dicTypeName"
		}); 
		$("form").validate({
			submitHandler : function(form) {//必须写在验证前面，否则无法ajax提交
				$(form).ajaxSubmit({//验证新增是否成功
					type : "post",
					dataType:"json",
					success : function(data) {
						if (data.flag == "true") {
							$.ligerDialog.success('提交成功!', '提示', function() {
								//这个是调用同一个页面趾两个iframe里的js方法
								//account是iframe的id
								parent.dic.loadGird();
								closeWin();
							});
							//parent.window.document.getElementById("username").focus();
						} else {
							$.ligerDialog.warn("提交失败！！");
						}
					}
				});
			},
			rules : {
				dicKey : {
				required : true,
				remote:{ //异步验证是否存在
					type:"POST",
					url: rootPath + '/background/dic/isExist.html',
					data:{
						name:function(){return $("#dicKey").val();}
					 }
					}
				},
				enable : {
					required : true
				}
			},
			messages : {
				dicKey : {
					required : "请输入key名",
				    remote:"该key已经存在"
				},
				enable : {
					required : "选择状态"
				}
			},
			errorPlacement : function(error, element) {//自定义提示错误位置
				$(".l_err").css('display','block');
				//element.css('border','3px solid #FFCCCC');
				$(".l_err").html(error.html());
			},
			success: function(label) {//验证通过后
				$(".l_err").css('display','none');
			}
		});
	});
	function saveWin() {
		$("#form").submit();
	}
	function closeWin() {
		 parent.$.ligerDialog.close(); //关闭弹出窗; //关闭弹出窗
		parent.$(".l-dialog,.l-window-mask").css("display","none"); 
	}
	function getTypeDetail(id){
				$.ajax({
				    type: "post", //使用get方法访问后台
				    dataType: "json", //json格式的数据
				    async: true, //同步   不写的情况下 默认为true
				    url: rootPath + '/background/dicType/findDicTypeDetail.html', //要访问的后台地址
				    data:{"id":id},
				    success : function(data){
				    	$("#dicTypeId").val(data.id);
				    	
					}
				
	            });
    }
	
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 270px;"></div>
	<form name="form" id="form" action="${ctx}/background/dic/add.html" method="post">
		<table style="width: 285px; height: 200px;">
			<tbody>
			
				<tr>
					<td class="l_right">Key：</td>
					<td class="l_left">
					<div class="opms_input">
					<input id='dicKey' name="dicKey" class="checkdesc" type="text" value="">
						</div></td>
				</tr>
				<tr>
					<td class="l_right">名称：</td>
					<td class="l_left">
					<div class="opms_input">
					<input id='dicName' name="dicName" type="text" value="">
						</div>
					</td>
				</tr>
				<tr>
					<td class="l_right">类型名称：</td>
					<td class="l_left">
					<select name="dicTypeId" id="dicTypeId" style="width: 140px;" onchange="getTypeDetail(this.value)">
							 <option value="">--请选择--</option>
     						 
					</select>
						</td>
				</tr>
				<tr>
					<td class="l_right">描述：</td>
					<td class="l_left">
					<div class="opms_input">
					<input id='description' name="description" class="checkdesc" type="text" value="">
						</div></td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="l_btn_centent">
								<!-- saveWin_form   from是表单Ｉd-->
								<a class="btn btn-primary" href="javascript:void(0)"
									id="saveWin_form" onclick="saveWin();"><span>保存</span> </a> <a
									class="btn btn-primary" href="javascript:void(0)" id="closeWin"
									onclick="closeWin()"><span>关闭</span> </a>
							</div>
						</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>