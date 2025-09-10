//
//  Menu.swift
//  iOSFinalProject
//
//  Created by Akira Hanada on 2025/09/10.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    @State private var selectedCategory = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Dish.title, ascending: true)],
        animation: .default)
    private var dishes: FetchedResults<Dish>
    
    let categories = ["Starters", "Mains", "Desserts", "Drinks"]
    
    // Map display names to API category names
    private func getCategoryKey(for displayName: String) -> String {
        switch displayName {
        case "Starters": return "starters"
        case "Mains": return "mains"
        case "Desserts": return "desserts"
        case "Drinks": return "drinks"
        default: return displayName.lowercased()
        }
    }
    
    // Computed property to filter dishes
    private var filteredDishes: [Dish] {
        let dishArray = Array(dishes)
        
        return dishArray.filter { dish in
            let matchesSearch = searchText.isEmpty || 
                (dish.title?.localizedCaseInsensitiveContains(searchText) ?? false)
            
            let matchesCategory = selectedCategory.isEmpty || 
                (dish.category == getCategoryKey(for: selectedCategory))
            
            let result = matchesSearch && matchesCategory
            
            if !selectedCategory.isEmpty {
                print("Dish: \(dish.title ?? "nil"), Category: \(dish.category ?? "nil"), Selected: \(getCategoryKey(for: selectedCategory)), Matches: \(matchesCategory)")
            }
            
            return result
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // HEADER Section
            HStack {
                HStack(spacing: 8) {
                    Image("little-lemon-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                }
                
                Spacer()
                
                Button(action: {
                    // Navigate to profile
                }) {
                    AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.littleLemonGreen)
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                }
            }
            .padding()
            .background(Color.white)
            
            // HERO Section
            VStack(alignment: .leading, spacing: 15) {
                HStack(alignment: .top, spacing: 15) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Little Lemon")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.littleLemonYellow)
                        
                        Text("Chicago")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .font(.body)
                            .foregroundColor(.white)
                            .lineLimit(4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image("hero-food-image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .cornerRadius(16)
                }
                
                // Search Field
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search menu", text: $searchText)
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
            .padding()
            .background(Color.littleLemonGreen)
            
            // MENU BREAKDOWN Section
            VStack(alignment: .leading, spacing: 15) {
                Text("ORDER FOR DELIVERY!")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.littleLemonDark)
                    .padding(.horizontal)
                
                // Category Filter Buttons
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                print("Category button tapped: \(category)")
                                selectedCategory = selectedCategory == category ? "" : category
                                print("Selected category is now: \(selectedCategory)")
                            }) {
                                Text(category)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 12)
                                    .background(selectedCategory == category ? Color.littleLemonGreen : Color.gray.opacity(0.2))
                                    .foregroundColor(selectedCategory == category ? .white : .littleLemonDark)
                                    .cornerRadius(20)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
            .background(Color.white)
            
            Divider()
            
            // FOOD MENU LIST Section
            List {
                ForEach(filteredDishes, id: \.self) { dish in
                    VStack(spacing: 0) {
                        HStack(spacing: 15) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(dish.title ?? "Unknown Dish")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                
                                Text(dish.desc ?? "")
                                    .font(.body)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                
                                Text("$\(dish.price ?? "0.00")")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                                switch phase {
                                case .empty:
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 90, height: 90)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 90, height: 90)
                                        .clipped()
                                case .failure(_):
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 90, height: 90)
                                        .overlay(
                                            Image(systemName: "photo")
                                                .foregroundColor(.gray)
                                        )
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .cornerRadius(0)
                        }
                        .padding(.vertical, 16)
                        
                        if dish != filteredDishes.last {
                            Divider()
                                .background(Color.gray.opacity(0.3))
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
        }
        .onAppear {
            getMenuData()
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let serverURL = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        guard let url = URL(string: serverURL) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let menuList = try decoder.decode(MenuList.self, from: data)
                DispatchQueue.main.async {
                    for menuItem in menuList.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        dish.desc = menuItem.description
                        dish.category = menuItem.category
                        print("Saved dish: \(menuItem.title) with category: \(menuItem.category)")
                    }
                    
                    do {
                        try viewContext.save()
                        print("Menu data saved successfully")
                    } catch {
                        print("Failed to save context: \(error.localizedDescription)")
                    }
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
