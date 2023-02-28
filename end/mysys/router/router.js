const express = require('express')
const con = require('../modul/db.js')

const router = express.Router()

let db= con.handleDisconnection()

// 处理数据的函数
// data 数据
// root 顶级数据
let getChildren = function (data, root) {
  var children = [];
  for (var i = 0; i < data.length; i++) {
    if (root == data[i].super) {
      data[i].children = getChildren(data, data[i].id);
      children.push(data[i]);
    }
  }
  return children;
}

// 获取所有部门信息
router.get('/getsection', (req, res) => {
  let sql = `SELECT * FROM section`
  db.query({
    sql: sql
  }, (err, results) => {
    if (err) {
      console.log(err)
    } else {
      res.send(getChildren(results, 0))
    }
  })
})

// 根据部门id请求对应部门员工信息  参数 部门id
router.get('/getstaff', (req, res) => {
  let id = req.query.id
  let sql = `SELECT * FROM staff WHERE staff.seid = '${id}'`
  db.query({
    sql: sql
  }, (err, results, fields) => {
    res.send(results)
  })

})


// 获取岗位信息
router.get('/getpost', (req, res) => {
  let sql = `SELECT * FROM post`
  db.query({
    sql: sql
  }, (err, results, fields) => {
    res.send(results)
  })

})

//// 添加数据
router.post('/addstaff', (req, res) => {
  let sql = `INSERT INTO staff (name,sex,birthday,other,seid,poid) values ('${req.body.name}','${req.body.sex}','${req.body.birthday}','${req.body.other}',${req.body.seid},${req.body.poid})`
  db.query(sql, (err, result) => {
    if (err) {
      console.log(err)
    } else {
      res.json({
        code: 200
      })
    }
  })
})

// 搜索员工信息
router.get('/findstaff', (req, res) => {
  let seid = req.query.seid //部门id
  let poid = req.query.poid //岗位id
  let name = req.query.name //员工姓名
  if (poid) {
    sql = `SELECT * FROM staff WHERE staff.poid = '${poid}' AND staff.seid = ${seid} and staff.name LIKE '%${name}%';`
  } else {
    sql = `SELECT * FROM staff WHERE  staff.seid = ${seid} and staff.name LIKE '%${name}%';`
  }
  db.query({
    sql: sql
  }, (err, results, fields) => {
    console.log(results)
    res.send(results)
  })

})

// 删除员工

router.get('/removestaff', (req, res) => {
  let id = req.query.id
  let sql = `DELETE FROM staff WHERE id = '${id}'`
  db.query(sql, (err, result) => {
    if (err) {
      console.log(err)
    } else {
      res.json({
        code: 200
      })
    }
  })
})


// 按员工id获取员工
router.get('/staff_id', (req, res) => {
  let id = req.query.id
  let sql = `SELECT * FROM staff WHERE staff.id = ${id} `
  db.query(sql, (err, result) => {
    if (err) {
      console.log(err)
    } else {
      res.send(result)
    }
  })
})

// 更新 员工信息
router.post('/update', (req, res) => {
  let id = req.body.id,
    sta = req.body,
   
    newSta = [sta.name, sta.sex, sta.birthday, sta.other, sta.seid, sta.poid]
  let sql = `UPDATE staff SET name = ?, sex = ?, birthday = ?, other = ?, seid = ?, poid = ? WHERE id = ${req.body.id}`
  db.query(sql, newSta, (err, result) => {
    if (err) {
      console.log(err)
    } else {
      res.json({
        code: 200
      })
    }
  })
})


module.exports = router