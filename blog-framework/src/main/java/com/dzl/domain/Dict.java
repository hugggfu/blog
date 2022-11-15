package com.dzl.domain;


import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
/**
 * (Dict)表实体类
 *
 * @author 都忠良
 * @since 2022-09-27 22:33:47
 */
@SuppressWarnings("serial")
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("sys_dict")
public class Dict  {

    //名称
    private String name;
    //内容
    private String value;
    //类型
    private String type;



}

