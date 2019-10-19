//
//  NewsManager.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/22.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

var all = [(1,"Among all the attention variants","Among all the attention variants, monotonic attention has demonstrated to be particularly effective to strictly preserve monotonicity and locality, and has been applied to multiple tasks including TTS [15, 16]. The mechanism could be described as follows [17]: at each step 𝑖 , the mechanism inspects the memory entries from the memory index 𝑡 ௜ିଵ it focused on at the previous step. Then energy valu","Among all the attention variants, monotonic attention has demonstrated to be particularly effective to strictly preserve monotonicity and locality, and has been applied to multiple tasks including TTS [15, 16]. The mechanism could be described as follows [17]: at each step 𝑖 , the mechanism inspects the memory entries from the memory index 𝑡 ௜ିଵ it focused on at the previous step. Then energy valu"),(2,"Similarly, the inference of stepwise monotonic attention involves with sampling","Similarly, the inference of stepwise monotonic attention involves with sampling: for each timestep 𝑖, the mechanism inspects the memory entry 𝑗 = 𝑡 ௜ିଵ it attended to at the previous step, and sample from the corresponding Bernoulli distribution as in section 2.2. However, we only need to decide whether move forward by one step or stay unmoved. Therefore, we could directly form the recursive relation of the distribution of 𝑝 ௜,௝ in Equation (7)Similarly, the inference of stepwise monotonic attention involves with sampling: for each timestep 𝑖, the mechanism inspects the memory entry 𝑗 = 𝑡 ௜ିଵ it attended to at the previous step, and sample from the corresponding Bernoulli distribution as in section 2.2. However, we only need to decide whether move forward by one step or stay unmoved. Therefore, we could directly form the recursive relation of the distribution of 𝑝 ௜,௝ in Equation (7)Similarly, the inference of stepwise monotonic attention involves with sampling: for each timestep 𝑖, the mechanism inspects the memory entry 𝑗 = 𝑡 ௜ିଵ it attended to at the previous step, and sample from the corresponding Bernoulli distribution as in section 2.2. However, we only need to decide whether move forward by one step or stay unmoved. Therefore, we could directly form the recursive relation of the distribution of 𝑝 ௜,௝ in Equation (7)Similarly, the inference of stepwise monotonic attention involves with sampling: for each timestep 𝑖, the mechanism inspects the memory entry 𝑗 = 𝑡 ௜ିଵ it attended to at the previous step, and sample from the corresponding Bernoulli distribution as in section 2.2. However, we only need to decide whether move forward by one step or stay unmoved. Therefore, we could directly form the recursive relation of the distribution of 𝑝 ௜,௝ in Equation (7),","Similarly, the inference of stepwise monotonic attention involves with sampling: for each timestep 𝑖, the mechanism inspects the memory entry 𝑗 = 𝑡 ௜ିଵ it attended to at the previous step, and sample from the corresponding Bernoulli distribution as in section 2.2. However, we only need to decide whether move forward by one step or stay unmoved. Therefore, we could directly form the recursive relation of the distribution of 𝑝 ௜,௝ in Equation (7)Similarly, the inference of stepwise monotonic attention involves with sampling: for each timestep 𝑖, the mechanism inspects the memory entry 𝑗 = 𝑡 ௜ିଵ it attended to at the previous step, and sample from the corresponding Bernoulli distribution as in section 2.2. However, we only need to decide whether move forward by one step or stay unmoved. Therefore, we could directly form the recursive relation of the distribution of 𝑝 ௜,௝ in Equation (7)Similarly, the inference of stepwise monotonic attention involves with sampling: for each timestep 𝑖, the mechanism inspects the memory entry 𝑗 = 𝑡 ௜ିଵ it attended to at the previous step, and sample from the corresponding Bernoulli distribution as in section 2.2. However, we only need to decide whether move forward by one step or stay unmoved. Therefore, we could directly form the recursive relation of the distribution of 𝑝 ௜,௝ in Equation (7)Similarly, the inference of stepwise monotonic attention involves with sampling: for each timestep 𝑖, the mechanism inspects the memory entry 𝑗 = 𝑡 ௜ିଵ it attended to at the previous step, and sample from the corresponding Bernoulli distribution as in section 2.2. However, we only need to decide whether move forward by one step or stay unmoved. Therefore, we could directly form the recursive relation of the distribution of 𝑝 ௜,௝ in Equation (7)Similarly, the inference of stepwise monotonic attention involves with sampling: for each timestep 𝑖, the mechanism inspects the memory entry 𝑗 = 𝑡 ௜ିଵ it attended to at the previous step, and sample from the corresponding Bernoulli distribution as in section 2.2. However, we only need to decide whether move forward by one step or stay unmoved. Therefore, we could directly form the recursive relation of the distribution of 𝑝 ௜,௝ in Equation (7),")]
func get_all() -> [(Int, String, String, String)] {
    
    let urlPath = "http://localhost:8888/show_all"
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return []
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
    
    //let json = ["0":"1"]
    do {
        let data = try JSONSerialization.data(withJSONObject: [], options: [])
        request.httpBody = data
    } catch {
        print("Error while serialize json data")
        return []
    }
    
    var all_news = [(Int, String, String, String)]()
    var finished = false
    
    print("to get_all")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let news = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                news.forEach { (cur_id, cur_content) in
                    all_news.append((Int(cur_id) ?? 0 ,cur_content[0], cur_content[1], cur_content[2]))
                }
            }
            
            finished = true
        } catch let err as NSError {
            print("catch error:\(err.debugDescription)")
        }
    }
    task.resume()
    
    while(finished == false) {
        
    }
    //print(all_news)
    return all_news.sorted(by: {(a,b) in a.0 < b.0})
 
 /*
    print("to get all")
    return all
 */
}

func get_target(id: Int) -> (Int, String, String, String) {
    
    let urlPath = "http://localhost:8888/show_target?" + String(id)
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return (-1,"","","")
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
    
    //let json = ["0":"1"]
    do {
        let data = try JSONSerialization.data(withJSONObject: [], options: [])
        request.httpBody = data
    } catch {
        print("Error while serialize json data")
    }
    
    var target_news : (Int, String, String, String) = (-1,"","","")
    var finished = false
    
    print("to get_target")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            //print(try? JSONSerialization.jsonObject(with: data, options: []))
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let news = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                news.forEach { (cur_id, cur_content) in
                    target_news = (Int(cur_id) ?? -1 ,cur_content[0], cur_content[1], cur_content[2])
                }
            }
            
            finished = true
        } catch let err as NSError {
            print("catch error:\(err.debugDescription)")
        }
    }
    task.resume()
    
    while(finished == false) {
        
    }
    return target_news
 /*
    print("to get \(id)")
    return all[id] //(1,"a","aa","aaa")
 */
}


func get_all_2() -> [(Int, String, String, String)] {
    
    let urlPath = "http://localhost:8888/show_all_2"
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return []
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
    
    //let json = ["0":"1"]
    do {
        let data = try JSONSerialization.data(withJSONObject: [], options: [])
        request.httpBody = data
    } catch {
        print("Error while serialize json data")
        return []
    }
    
    var all_news = [(Int, String, String, String)]()
    var finished = false
    
    print("to get_all")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let news = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                news.forEach { (cur_id, cur_content) in
                    all_news.append((Int(cur_id) ?? 0 ,cur_content[0], cur_content[1], cur_content[2]))
                }
            }
            
            finished = true
        } catch let err as NSError {
            print("catch error:\(err.debugDescription)")
        }
    }
    task.resume()
    
    while(finished == false) {
        
    }
    //print(all_news)
    return all_news.sorted(by: {(a,b) in a.0 < b.0})
 
 /*
    print("to get all")
    return all
 */
}

func get_target_2(id: Int) -> (Int, String, String, String) {
    
    let urlPath = "http://localhost:8888/show_target_2?" + String(id)
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return (-1,"","","")
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
    
    //let json = ["0":"1"]
    do {
        let data = try JSONSerialization.data(withJSONObject: [], options: [])
        request.httpBody = data
    } catch {
        print("Error while serialize json data")
    }
    
    var target_news : (Int, String, String, String) = (-1,"","","")
    var finished = false
    
    print("to get_target")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            //print(try? JSONSerialization.jsonObject(with: data, options: []))
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let news = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                news.forEach { (cur_id, cur_content) in
                    target_news = (Int(cur_id) ?? -1 ,cur_content[0], cur_content[1], cur_content[2])
                }
            }
            
            finished = true
        } catch let err as NSError {
            print("catch error:\(err.debugDescription)")
        }
    }
    task.resume()
    
    while(finished == false) {
        
    }
    return target_news
 /*
    print("to get \(id)")
    return all[id] //(1,"a","aa","aaa")
 */
}

func get_all_3() -> [(Int, String, String, String)] {
    
    let urlPath = "http://localhost:8888/show_all_3"
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return []
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
    
    //let json = ["0":"1"]
    do {
        let data = try JSONSerialization.data(withJSONObject: [], options: [])
        request.httpBody = data
    } catch {
        print("Error while serialize json data")
        return []
    }
    
    var all_news = [(Int, String, String, String)]()
    var finished = false
    
    print("to get_all")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let news = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                news.forEach { (cur_id, cur_content) in
                    all_news.append((Int(cur_id) ?? 0 ,cur_content[0], cur_content[1], cur_content[2]))
                }
            }
            
            finished = true
        } catch let err as NSError {
            print("catch error:\(err.debugDescription)")
        }
    }
    task.resume()
    
    while(finished == false) {
        
    }
    //print(all_news)
    return all_news.sorted(by: {(a,b) in a.0 < b.0})
 
 /*
    print("to get all")
    return all
 */
}

func get_target_3(id: Int) -> (Int, String, String, String) {
    
    let urlPath = "http://localhost:8888/show_target_3?" + String(id)
    guard let endpoint = URL(string: urlPath) else {
        print("Error creating endpoint")
        return (-1,"","","")
    }
    
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("Bearer tokens", forHTTPHeaderField: "authorization")
    
    //let json = ["0":"1"]
    do {
        let data = try JSONSerialization.data(withJSONObject: [], options: [])
        request.httpBody = data
    } catch {
        print("Error while serialize json data")
    }
    
    var target_news : (Int, String, String, String) = (-1,"","","")
    var finished = false
    
    print("to get_target")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            guard let data = data else {
                return
            }
            //print(try? JSONSerialization.jsonObject(with: data, options: []))
            // It seems that the key for json must be String! so is cast to [String,Int]!
            if let news = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                news.forEach { (cur_id, cur_content) in
                    target_news = (Int(cur_id) ?? -1 ,cur_content[0], cur_content[1], cur_content[2])
                }
            }
            
            finished = true
        } catch let err as NSError {
            print("catch error:\(err.debugDescription)")
        }
    }
    task.resume()
    
    while(finished == false) {
        
    }
    return target_news
 /*
    print("to get \(id)")
    return all[id] //(1,"a","aa","aaa")
 */
}
